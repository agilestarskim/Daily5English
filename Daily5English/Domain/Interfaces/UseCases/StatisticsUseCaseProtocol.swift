//
//  StatisticsUseCaseProtocol.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

protocol StatisticsUseCase {
    func fetchStatistics(userId: String) async throws -> LearningStatistics
    func fetchLearningStreak() async throws -> Int
}
