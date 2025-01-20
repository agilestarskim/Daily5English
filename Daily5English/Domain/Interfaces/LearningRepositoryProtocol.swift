protocol LearningRepositoryProtocol {
    func fetchRandomWords(setting: LearningSetting, learnedWordIds: [Int]) async throws -> [Word]
    func saveLearnedWords(userId: String, wordIds: [Int]) async throws
}
