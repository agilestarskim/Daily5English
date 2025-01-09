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
} 
