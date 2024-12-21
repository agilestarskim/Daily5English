//
//  LearningCategory.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

enum LearningCategory {
    case daily, business
    
    func toString() -> String {
        switch self {
        case .daily: return "일상"
        case .business: return "비즈니스"
        }
    }
}
