import AVFoundation

/// 프로토타입: 음성(TTS) 낭독 중 배경음을 자동으로 줄이는 덕킹 확인용.
/// 추후 Kokoro 합성 파일 재생으로 교체한다.
@Observable
final class BriefingPlayer: NSObject, AVSpeechSynthesizerDelegate {
    private let synth = AVSpeechSynthesizer()
    private var background: AVAudioPlayer?
    private let normalVolume: Float = 0.6
    private let duckedVolume: Float = 0.2

    override init() {
        super.init()
        synth.delegate = self
    }

    func play(text: String, backgroundURL: URL? = nil) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
        try? AVAudioSession.sharedInstance().setActive(true)
        if let url = backgroundURL, let p = try? AVAudioPlayer(contentsOf: url) {
            p.numberOfLoops = -1
            p.volume = 0
            p.play()
            p.setVolume(normalVolume, fadeDuration: 2)
            background = p
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.45
        synth.speak(utterance)
    }

    func speechSynthesizer(_ s: AVSpeechSynthesizer, didStart u: AVSpeechUtterance) {
        background?.setVolume(duckedVolume, fadeDuration: 0.5)
    }

    func speechSynthesizer(_ s: AVSpeechSynthesizer, didFinish u: AVSpeechUtterance) {
        background?.setVolume(normalVolume, fadeDuration: 1)
    }
}
