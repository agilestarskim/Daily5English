protocol LearningRepositoryProtocol {
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word]
}
