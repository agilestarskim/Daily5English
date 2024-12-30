import Foundation
import SwiftData

@Model
final class LocalQuizSession {
    var id: String
    var userId: String
    var learningSessionId: String
    var startTime: Date
    var endTime: Date?
    var quizzes: [Quiz]
    var currentQuizIndex: Int
    var correctCount: Int
    var isCompleted: Bool
    
    init(from domain: QuizSession) {
        self.id = domain.id
        self.userId = domain.userId
        self.learningSessionId = domain.learningSessionId
        self.startTime = domain.startTime
        self.endTime = domain.endTime
        self.quizzes = domain.quizzes
        self.currentQuizIndex = domain.currentQuizIndex
        self.correctCount = domain.correctCount
        self.isCompleted = domain.isCompleted
    }
    
    func update(from domain: QuizSession) {
        self.endTime = domain.endTime
        self.currentQuizIndex = domain.currentQuizIndex
        self.correctCount = domain.correctCount
        self.isCompleted = domain.isCompleted
    }
    
    func toDomain() -> QuizSession {
        QuizSession(
            id: id,
            userId: userId,
            learningSessionId: learningSessionId,
            startTime: startTime,
            endTime: endTime,
            quizzes: quizzes,
            currentQuizIndex: currentQuizIndex,
            correctCount: correctCount,
            isCompleted: isCompleted
        )
    }
} 
