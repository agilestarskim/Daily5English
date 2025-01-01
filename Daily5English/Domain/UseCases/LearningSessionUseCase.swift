import Foundation

final class LearningSessionUseCase {
    
    private let repository: LearningRepository
    
    init(repository: LearningRepository) {
        self.repository = repository
    }
    
    func isLearningCompleted(userId: String) async throws -> Bool {
        return false
    }
    
    func fetchWords(setting: LearningSetting) async throws -> [Word] {
        return try await repository.fetchRandomWords(setting: setting)
    }
}
