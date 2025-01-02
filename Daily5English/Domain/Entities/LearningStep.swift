//
//  LearningStep.swift
//  Daily5English
//
//  Created by 김민성 on 1/2/25.
//

// 학습 단계를 나타내는 열거형
enum LearningStep {
    case ready    // 초기 데이터 로딩 상태
    case learning // 단어 학습 상태
    case quiz     // 퀴즈 상태
    case result   // 결과 상태
}
