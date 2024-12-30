import Foundation

struct QuizSession: Identifiable {
    let id: String
    let userId: String
    let learningSessionId: String
    let startTime: Date
    var endTime: Date?
    let quizzes: [Quiz]
    var currentQuizIndex: Int
    var correctCount: Int
    var isCompleted: Bool
    
    // 진행률 계산
    var progress: Float {
        guard !quizzes.isEmpty else { return 0 }
        return Float(currentQuizIndex) / Float(quizzes.count)
    }
    
    // 정답률 계산
    var accuracy: Float {
        guard !quizzes.isEmpty else { return 0 }
        return Float(correctCount) / Float(quizzes.count)
    }
    
    // 소요 시간 계산
    var duration: TimeInterval? {
        guard let endTime = endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }
} 
