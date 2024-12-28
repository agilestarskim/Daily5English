//
//  Quiz.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct Quiz: Codable {
    let word: Word
    let quizType: QuizType
    var isCorrect: Bool    
    
    enum QuizType: String, Codable {
        case korToEng
        case engToKor
        case spell
    }
}
