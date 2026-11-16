# Whisper Wake

## 개요·기술 스택
- 일정을 내 목소리/AI 음성으로 읽어주며 깨우는 iOS 전용 알람. 번들 ID `com.addvalue.whisperwake`
- Swift 6 / SwiftUI, 최소 iOS 18.0, 로컬 저장(SwiftData 예정), 서버 없음
- TTS: Kokoro-82M CoreML(예정, 한국어 품질 미검증) → 폴백 AVSpeechSynthesizer
- 알람: AlarmKit(iOS 26+) 검증 예정, 폴백 로컬 알림
- 프로젝트 생성: XcodeGen (`project.yml`). `.xcodeproj`는 git 제외, 재생성해서 쓴다

## 폴더 구조
- `WhisperWake/App` 앱 진입점·화면
- `WhisperWake/Audio` 낭독·배경음·덕킹
- `WhisperWake/Alarm` 알람 스케줄링
- `docs/기획안.md` 전체 기획

## 규칙
- 오프라인·온디바이스 우선, 일정 데이터 외부 전송 금지
- 알람 시각에 합성하지 않는다: 전날 밤/변경 시 음성 파일을 미리 만들어 캐시
- 공유·OCR 등으로 들어온 일정은 자동 등록 금지, 미리듣기 후 확정

## 명령어·현재 상태
- 생성: `.tools/xcodegen/bin/xcodegen generate` (스킴 `WhisperWake`)
- 빌드: 공통 지침의 xcodebuild 명령에서 `-project WhisperWake.xcodeproj -scheme WhisperWake`
- 상태: 뼈대 + TTS 미리듣기/덕킹/알림 테스트 프로토타입, 앱 아이콘 적용. 다음: Kokoro 한국어 검증, AlarmKit 실기기 검증
