import SwiftUI

struct ContentView: View {
    @State private var text = "오늘은 일정이 두 개 있어요. 아홉 시 치과, 열한 시 팀 회의."
    @State private var player = BriefingPlayer()

    var body: some View {
        VStack(spacing: 16) {
            Text("Whisper Wake").font(.largeTitle.bold())
            TextEditor(text: $text)
                .frame(height: 140)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary))
            Button("미리듣기") { player.play(text: text) }
                .buttonStyle(.borderedProminent)
            Button("5초 뒤 알림 테스트") {
                Task { await AlarmScheduler.scheduleTest(text: text, after: 5) }
            }
        }
        .padding()
    }
}
