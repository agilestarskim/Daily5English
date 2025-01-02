protocol LearningRepositoryProtocol {
    // 서버 통신
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
    func saveLearningStatistics(_ statistics: LearningStatistics) async throws
} 
