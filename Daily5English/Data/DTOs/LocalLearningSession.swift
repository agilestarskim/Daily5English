import Foundation
import SwiftData


@Model
final class LocalLearningSession {
    var id: String
    var userId: String
    var date: Date
    var words: [Word]
    var isCompleted: Bool
    var lastStudiedWordIndex: Int
    
    init(from domain: LearningSession) {
        self.id = domain.id
        self.userId = domain.userId
        self.date = domain.date
        self.words = domain.words
        self.isCompleted = domain.isCompleted
        self.lastStudiedWordIndex = domain.lastStudiedWordIndex
    }
    
    func update(from domain: LearningSession) {
        self.isCompleted = domain.isCompleted
        self.lastStudiedWordIndex = domain.lastStudiedWordIndex
    }
    
    func toDomain() -> LearningSession {
        LearningSession(
            id: id,
            userId: userId,
            date: date,
            words: words,
            isCompleted: isCompleted,
            lastStudiedWordIndex: lastStudiedWordIndex
        )
    }
} 
