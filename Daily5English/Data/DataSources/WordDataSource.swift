import Foundation

protocol WordDataSource {
    func getWords() async throws -> [Word]
    func saveWord(_ word: Word) async throws
    func deleteWord(_ word: Word) async throws
}

final class LocalWordDataSource: WordDataSource {
    func getWords() async throws -> [Word] {
        // UserDefaults나 CoreData 구현 예정
        return []
    }
    
    func saveWord(_ word: Word) async throws {
        // 구현 예정
    }
    
    func deleteWord(_ word: Word) async throws {
        // 구현 예정
    }
} 