//
//  LearningSettingsUseCase.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

final class LearningSettingsUseCase: LearningSettingsUseCaseProtocol {
    
    private let repository: LearningSettingsRepositoryProtocol
    
    init(repository: LearningSettingsRepositoryProtocol) {
        self.repository = repository
    }
    
    func update(settings: LearningSettings) async throws {
        try await repository.update(settings: settings)
    }
    
    func fetch(userId: String) async throws -> LearningSettings? {
        return try await repository.fetch(userId: userId)
    }
}
