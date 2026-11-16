import UserNotifications

/// 프로토타입: 로컬 알림 폴백 경로. AlarmKit(iOS 26+) 연동은 실기기 검증 후 추가한다.
enum AlarmScheduler {
    static func scheduleTest(text: String, after seconds: TimeInterval) async {
        let center = UNUserNotificationCenter.current()
        guard (try? await center.requestAuthorization(options: [.alert, .sound])) == true else { return }
        let content = UNMutableNotificationContent()
        content.title = "Whisper Wake"
        content.body = text
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        try? await center.add(UNNotificationRequest(identifier: "test", content: content, trigger: trigger))
    }
}
