protocol LearningRepositoryProtocol {
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
    func updateLearningCompletion(userId: String, wordsCount: Int) async throws
    func fetchLearningStatistics(userId: String) async throws -> LearningStatistics 
}
