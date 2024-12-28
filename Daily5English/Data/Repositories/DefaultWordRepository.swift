import Foundation

protocol WordRepository {
    func getWords() async throws -> [Word]
    func saveWord(_ word: Word) async throws
    func deleteWord(_ word: Word) async throws
}

final class DefaultWordRepository: WordRepository {
    private let dataSource: WordDataSource
    
    init(dataSource: WordDataSource) {
        self.dataSource = dataSource
    }
    
    func getWords() async throws -> [Word] {
        return try await dataSource.getWords()
    }
    
    func saveWord(_ word: Word) async throws {
        try await dataSource.saveWord(word)
    }
    
    func deleteWord(_ word: Word) async throws {
        try await dataSource.deleteWord(word)
    }
} 
