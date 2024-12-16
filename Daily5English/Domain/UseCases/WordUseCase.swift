import Foundation

protocol WordUseCase {
    func getWords() async throws -> [Word]
    func saveWord(_ word: Word) async throws
    func deleteWord(_ word: Word) async throws
}

final class DefaultWordUseCase: WordUseCase {
    private let repository: WordRepository
    
    init(repository: WordRepository) {
        self.repository = repository
    }
    
    func getWords() async throws -> [Word] {
        return try await repository.getWords()
    }
    
    func saveWord(_ word: Word) async throws {
        try await repository.saveWord(word)
    }
    
    func deleteWord(_ word: Word) async throws {
        try await repository.deleteWord(word)
    }
} 