protocol LearningRepositoryProtocol {
    // 서버 통신
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
    func fetchQuizzes(words: [Word]) async throws -> [Quiz]
    func saveLearningStatistics(_ statistics: LearningStatistics) async throws
    
    // SwiftData 작업
    func saveLearningSession(_ session: LearningSession) throws
    func saveQuizSession(_ session: QuizSession) throws
    func getLearningSession(userId: String) throws -> LearningSession?
    func getQuizSession(userId: String) throws -> QuizSession?
    func updateLearningSession(_ session: LearningSession) throws
    func updateQuizSession(_ session: QuizSession) throws
} 
