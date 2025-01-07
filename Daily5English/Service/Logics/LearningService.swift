import SwiftUI

@Observable
final class LearningService {
    var error: LearningError?
    
    private let learningUseCase: LearningUseCase
    
    init(learningUseCase: LearningUseCase) {
        self.learningUseCase = learningUseCase
    }
    
    @MainActor
    func fetchWords(setting: LearningSetting) async -> [Word] {
        do {
            return try await learningUseCase.fetchWords(setting: setting)
        } catch {
            self.error = LearningError.networkError
            return []
        }
    }
    
    func createQuizzes(from words: [Word]) -> [Quiz] {
        return learningUseCase.fetchQuizzes(words: words)
    }
}
