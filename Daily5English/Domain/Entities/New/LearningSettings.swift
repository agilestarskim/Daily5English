//
//  LearningSettings.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct LearningSettings: Codable {
    let userId: String
    var difficulty: Difficulty
    var dailyWordCount: Int
    var category: LearningCategory
    
    enum Difficulty: String, Codable {
        case beginner
        case intermediate
        case advanced
    }
    
    enum LearningCategory: String, Codable {
        case daily
        case business
        case all
    }
}
