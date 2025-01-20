//
//  LearnedWord.swift
//  Production
//
//  Created by 김민성 on 01/10/25.
//
import Foundation

struct LearnedWord: Codable, Identifiable {
    let id: Int
    let word: Word
    let learnedAt: Date
    let lastReviewedAt: Date?
    let reviewedCount: Int
    
    init(word: Word, learnedAt: Date, lastReviewedAt: Date?, reviewedCount: Int) {
        self.id = word.id
        self.word = word
        self.learnedAt = learnedAt
        self.lastReviewedAt = lastReviewedAt
        self.reviewedCount = reviewedCount
    }
} 
