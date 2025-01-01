protocol LearningRepositoryProtocol {
    // 서버 통신
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
    func fetchQuizzes(words: [Word]) async throws -> [Quiz]
    func saveLearningStatistics(_ statistics: LearningStatistics) async throws
} 
