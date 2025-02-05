//
//  LearningSetting.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

typealias Level = LearningSetting.Level
typealias Category = LearningSetting.Category

struct LearningSetting: Codable {
    let userId: String
    var level: Level
    var count: Int
    var category: Category
    
    enum Level: String, Codable, CaseIterable {
        case beginner
        case intermediate
        case advanced
        
        var text: String {
            switch self {
            case .beginner: return "쉬움"
            case .intermediate: return "보통"
            case .advanced: return "어려움"
            }
        }
    }
    
    enum Category: String, Codable, CaseIterable {
        case daily
        case business
        
        var text: String {
            switch self {
            case .daily: return "일상"
            case .business: return "비즈니스"
            }
        }
    }
    
    static let defaults: LearningSetting = .init(
        userId: "",
        level: .intermediate,
        count: 5,
        category: .daily
    )
}
