//
//  LearningCategory.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

enum LearningCategory {
    case daily, business
    
    init (string: String) {
        switch string {
        case "DAILY": self = .daily
        case "BUSINESS": self = .business
        default: self = .daily
        }
    }
    
    func toString() -> String {
        switch self {
        case .daily: return "일상"
        case .business: return "비즈니스"
        }
    }
    
    func toDBString() -> String {
        switch self {
        case .daily: return "DAILY"
        case .business: return "BUSINESS"
        }
    }
}
