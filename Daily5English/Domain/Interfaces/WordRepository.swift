import Foundation

protocol WordRepository {
    func getWords() async throws -> [Word]
    func saveWord(_ word: Word) async throws
    func deleteWord(_ word: Word) async throws
} 