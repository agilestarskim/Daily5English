//
//  LearningLevel.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

enum LearningLevel {
    case beginner, intermediate, advanced
    
    func toString() -> String {
        switch self {
        case .beginner: return "초급"
        case .intermediate: return "중급"
        case .advanced: return "고급"
        }
    }
}
