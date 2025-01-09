protocol WordBookRepositoryProtocol {
    func fetchLearnedWords(userId: String) async throws -> [LearnedWord]
}
