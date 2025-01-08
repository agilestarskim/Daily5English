//
//  LearningDateDTO.swift
//  Daily5English
//
//  Created by 김민성 on 1/8/25.
//

import Foundation

struct LearningDateDTO: Decodable {
    let learnedDate: String
    
    enum CodingKeys: String, CodingKey {
        case learnedDate = "learned_date"
    }
}
