//
//  LearningStatistics.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct LearningStatistics: Codable {
    let userId: String
    let date: Date
    var totalWordsLearned: Int
    var learningTime: TimeInterval
    var streakDays: Int
    var completedSessions: Int
}
