//
//  LearningTipDTP.swift
//  Daily5English
//
//  Created by 김민성 on 1/7/25.
//

import Foundation

struct LearningTipDTO: Codable, Hashable {
    let message: String
    let source: String
    
    func toDomain() -> LearningTip {
        return LearningTip(
            message: message,
            source: source
        )
    }
}

