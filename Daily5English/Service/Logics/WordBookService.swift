//
//  WordBookService.swift
//  Production
//
//  Created by 김민성 on 01/08/25.
//

import Foundation

@Observable
final class WordBookService {
    private let repository: WordBookRepository
    private var userId: String? = nil
    private(set) var words: [LearnedWord] = []
    private(set) var wordsCount: Int = 0
    private(set) var isLoading: Bool = false
    
    var error: Error?
    
    init(repository: WordBookRepository) {
        self.repository = repository
    }
    
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    @MainActor
    func fetchAllWords() async {
        guard let userId, !isLoading else { return }
        
        isLoading = true
        
        do {
            // 모든 단어를 한꺼번에 로드
            self.words = try await repository.fetchLearnedWords(userId: userId)
            self.wordsCount = self.words.count
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    @MainActor
    func refresh() async {
        words.removeAll()
        await fetchAllWords()
    }
}
