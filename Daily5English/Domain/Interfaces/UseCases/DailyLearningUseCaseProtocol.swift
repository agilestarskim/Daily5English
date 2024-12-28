//
//  DailyLearningUseCaseProtocol.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

protocol DailyLearningUseCaseProtocol {
    /// 오늘의 학습현황 정보를 가져온다.
    /// 학습을 시작했는지 여부를 판단한다.
    func getDailyLearningSession()
    
    /// 학습 세션을 만들기 위해 오늘의 단어를 학습설정에 맞게 가져온다.
    func getDailyLearningWords() async throws -> [Word]
    
    /// 학습을 시작한다.
    func startLearningSession() throws
    
    /// 학습을 중단한다.
    func stopLearningSession()
    
    /// 학습을 마친다.
    func completeWordLearning() async throws
}
