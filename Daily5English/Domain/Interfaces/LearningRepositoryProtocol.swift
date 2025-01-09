protocol LearningRepositoryProtocol {
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
    func saveLearnedWords(userId: String, wordIds: [Int]) async throws
}
