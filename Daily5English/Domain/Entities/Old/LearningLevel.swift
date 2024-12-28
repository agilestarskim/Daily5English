//
//  LearningLevel.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

enum LearningLevel {
    case beginner, intermediate, advanced
    
    init(string: String) {
        switch string {
        case "초급": self = .beginner
        case "중급": self = .intermediate
        case "고급": self = .advanced
        default: self = .intermediate
        }
    }
    
    func toString() -> String {
        switch self {
        case .beginner: return "초급"
        case .intermediate: return "중급"
        case .advanced: return "고급"
        }
    }
    
    func toDBString() -> String {
        switch self {
        case .beginner: return "EASY"
        case .intermediate: return "MEDIUM"
        case .advanced: return "HARD"
        }
    }
}
