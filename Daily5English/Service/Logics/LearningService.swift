import SwiftUI

@Observable
final class LearningService {
    
    var stat: LearningStatistics = .defaults
    
    private(set) var userId: String? = nil
    var error: LearningError?
    
    private let learningUseCase: LearningUseCase
    
    init(learningUseCase: LearningUseCase) {
        self.learningUseCase = learningUseCase
    }
    
    //로그인 성공시 꼭 호출해야함.
    func setUserId(_ userId: String) {
        self.userId = userId
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
    
    func saveStatistics(wordsCount: Int) async {
        guard let userId else {
            error = LearningError.serverError
            return
        }
        
        do {
            try await learningUseCase.saveStatistics(userId: userId, wordsCount: wordsCount)
            
        } catch {
            print("Fail to save statistics: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchStatistics() async {
        guard let userId else {
            error = LearningError.serverError
            return
        }
        
        do {
            let stat = try await learningUseCase.fetchStatistics(userId: userId)
            self.stat = stat
            
        } catch {
            self.error = LearningError.networkError
            print(error.localizedDescription)
        }
    }
}
