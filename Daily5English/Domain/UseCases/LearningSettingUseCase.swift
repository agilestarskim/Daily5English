//
//  LearningsettingUseCase.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

final class LearningSettingUseCase {
    
    private let repository: LearningSettingRepositoryProtocol
    
    init(repository: LearningSettingRepositoryProtocol) {
        self.repository = repository
    }
    
    func update(setting: LearningSetting) async throws {
        try await repository.update(setting: setting)
    }
    
    func fetch(userId: String) async throws -> LearningSetting? {
        return try await repository.fetch(userId: userId)
    }
}
