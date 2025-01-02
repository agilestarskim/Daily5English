//
//  Quiz.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct Quiz {
    let question: String           // 문제
    let options: [String]         // 보기 목록
    let correctAnswer: String     // 정답
    let type: QuizType           // 퀴즈 유형
}

enum QuizType: CaseIterable {
    case wordToMeaning     // 영단어 보고 한글 의미 고르기
    case meaningToWord     // 한글 의미 보고 영단어 고르기
    case exampleSentence   // 예문 빈칸 채우기
}
