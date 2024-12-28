//
//  AuthenticationUseCase.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//
final class UserSettingsUseCase {
    private let repository: UserSettingsRepository
    
    init(repository: UserSettingsRepository) {
        self.repository = repository
    }
    
    func saveSettings(settings: UserSettings) async throws {
        try await repository.saveUserSettings(settings)
    }
    
    func loadSettings(userId: String) async throws -> UserSettings? {
        return try await repository.getUserSettings(userId: userId)
    }
}
