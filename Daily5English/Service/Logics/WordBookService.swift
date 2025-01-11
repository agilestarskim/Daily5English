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
    private(set) var currentPage: Int = 0
    private(set) var isLoading: Bool = false
    private(set) var hasMoreData: Bool = true
    
    var error: Error?
    
    init(repository: WordBookRepository) {
        self.repository = repository
    }
    
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    @MainActor
    func fetchLearnedWords() async {
        guard let userId, !isLoading, hasMoreData else { return }
        
        isLoading = true
        
        do {
            let newWords = try await repository.fetchLearnedWords(userId: userId, page: currentPage)
            let uniqueNewWords = newWords.filter { newWord in
                !words.contains { $0.id == newWord.id }
            }
            self.words.append(contentsOf: uniqueNewWords)
            self.currentPage += 1
            self.hasMoreData = newWords.count == 20
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    @MainActor
    func refresh() async {
        self.words = []
        self.currentPage = 0
        self.hasMoreData = true
        await fetchLearnedWords()
    }
    
    func fetchCount() async {
        guard let userId else { return }
        
        do {
            self.wordsCount = try await repository.fetchCount(userId: userId)
        } catch {
            return
        }
    }
}
