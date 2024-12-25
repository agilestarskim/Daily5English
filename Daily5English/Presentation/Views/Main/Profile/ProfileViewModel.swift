import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userName = "사용자"
    @Published var userEmail = "user@example.com"
    
    @Published var learnedWords = 150
    @Published var streakDays = 7
    @Published var totalLearningDays = 14
    
    @Published var isNotificationEnabled = true
    @Published var learningStartTime = Date()
    @Published var reviewStartTime = Date()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
}
