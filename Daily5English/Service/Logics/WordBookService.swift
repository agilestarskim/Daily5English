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
    
    var error: Error?
    
    init(repository: WordBookRepository) {
        self.repository = repository
    }
    
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    @MainActor
    func fetchLearnedWords() async {
        guard let userId else { return }
        
        do {
            self.words = try await repository.fetchLearnedWords(userId: userId)
        } catch {
            self.error = error
        }
    }
} 
