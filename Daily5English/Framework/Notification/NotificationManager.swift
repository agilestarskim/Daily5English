import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() async -> Bool {
        return await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Error requesting notification authorization: \(error)")
                }
                continuation.resume(returning: granted)
            }
        }
    }
    
    func checkAuthorizationStatus() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func updateLearningNotification(at time: Date) {
        cancelNotification(withIdentifier: "learningNotification") {
            self.scheduleLearningNotification(at: time)
        }
    }
    
    func updateReviewNotification(at time: Date) {
        cancelNotification(withIdentifier: "reviewNotification") {
            self.scheduleReviewNotification(at: time)
        }
    }
    
    private func scheduleLearningNotification(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "학습 시간입니다!"
        content.body = "오늘의 학습을 시작해보세요."
        content.sound = .default
        
        let trigger = createTrigger(for: time)
        let request = UNNotificationRequest(identifier: "learningNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling learning notification: \(error)")
            } else {
                print("Learning notification scheduled for \(time)")
            }
        }
    }
    
    private func scheduleReviewNotification(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "복습 시간입니다!"
        content.body = "오늘 배운 내용을 복습해보세요."
        content.sound = .default
        
        let trigger = createTrigger(for: time)
        let request = UNNotificationRequest(identifier: "reviewNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling review notification: \(error)")
            } else {
                print("Review notification scheduled for \(time)")
            }
        }
    }
    
    private func createTrigger(for time: Date) -> UNCalendarNotificationTrigger {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        return UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
    }
    
    private func cancelNotification(withIdentifier identifier: String, completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        completion()
    }
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func checkIfNotificationsExist() async -> Bool {
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        let learningExists = requests.contains { $0.identifier == "learningNotification" }
        let reviewExists = requests.contains { $0.identifier == "reviewNotification" }
        return learningExists || reviewExists
    }
    
    func getNotificationTimes() async -> (learningTime: Date?, reviewTime: Date?) {
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        var learningTime: Date?
        var reviewTime: Date?
        
        for request in requests {
            if request.identifier == "learningNotification",
               let trigger = request.trigger as? UNCalendarNotificationTrigger {
                learningTime = trigger.nextTriggerDate()
            }
            if request.identifier == "reviewNotification",
               let trigger = request.trigger as? UNCalendarNotificationTrigger {
                reviewTime = trigger.nextTriggerDate()
            }
        }
        
        return (learningTime, reviewTime)
    }
} 