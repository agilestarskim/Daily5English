//
//  LearningStatistics.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct LearningStatistics: Codable, Identifiable {
    let id: String
    let userId: String
    let totalWordsCount: Int
    let streakDays: Int
    let totalLearningDays: Int
    let lastLearningDate: String
    
    static let defaults: LearningStatistics = .init(
        id: "",
        userId: "",
        totalWordsCount: 0,
        streakDays: 0,
        totalLearningDays: 0,
        lastLearningDate: ""
    )
}
