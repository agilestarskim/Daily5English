//
//  LearnedWord.swift
//  Production
//
//  Created by 김민성 on 01/10/25.
//
import Foundation

struct LearnedWord: Codable, Identifiable {
    let id: String
    let word: Word
    let learnedAt: Date
    let lastReviewedAt: Date?
    let reviewedCount: Int
    
    init(wordId: Int, word: Word, learnedAt: Date, lastReviewedAt: Date?, reviewedCount: Int) {
        self.id = "\(wordId)-\(learnedAt.timeIntervalSince1970)"
        self.word = word
        self.learnedAt = learnedAt
        self.lastReviewedAt = lastReviewedAt
        self.reviewedCount = reviewedCount
    }
} 
