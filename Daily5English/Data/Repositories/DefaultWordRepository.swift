import Foundation

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