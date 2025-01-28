import SwiftUI

@Observable
final class LearningService {
    var error: LearningError?
    
    private let learningUseCase: LearningUseCase
    private var userId: String? = nil
    private let userDefaults = UserDefaults.standard
    private(set) var hasLearnToday: Bool = false
    
    init(learningUseCase: LearningUseCase) {
        self.learningUseCase = learningUseCase
    }
    
    //로그인 성공시 꼭 호출해야함.
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    @MainActor
    func fetchHasLearnToday() async {
        guard let userId else { return }
        do {
            self.hasLearnToday = try await learningUseCase.hasLearnedToday(userId: userId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchWords(setting: LearningSetting) async -> [Word] {
        do {
            return try await learningUseCase.fetchWords(setting: setting)
        } catch {
            self.error = LearningError.networkError
            print(error.localizedDescription)
            return []
        }
    }
    
    func createQuizzes(from words: [Word]) -> [Quiz] {
        return learningUseCase.fetchQuizzes(words: words)
    }
    
    func saveLearnedWords(words: [Word]) async {
        guard let userId else { return }
        guard !hasLearnToday else { return }
        
        do {
            try await learningUseCase.saveLearnedWords(userId: userId, words: words)
        } catch {
            self.error = .networkError
        }
    }
}
