class UserSettingsRepositoryImpl: UserSettingsRepository {
    private let dataSource: UserSettingsDataSource
    
    init(dataSource: UserSettingsDataSource) {
        self.dataSource = dataSource
    }
    
    func saveUserSettings(_ settings: UserSettings) async throws {
        let dto = UserSettingsDTO(
            userId: settings.userId,
            difficultyLevel: settings.difficultyLevel.toDBString(),
            dailyWordCount: settings.dailyWordCount,
            categoryPreference: settings.categoryPreference.toDBString()
        )
        try await dataSource.saveUserSettings(dto)
    }
    
    func getUserSettings(userId: String) async throws -> UserSettings? {
        guard let dto = try await dataSource.getUserSettings(userId: userId) else {
            return nil
        }
        return dto.toDomain()
    }
} 