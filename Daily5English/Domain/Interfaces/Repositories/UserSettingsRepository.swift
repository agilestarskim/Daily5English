protocol UserSettingsRepository {
    func saveUserSettings(_ settings: UserSettings) async throws
    func getUserSettings(userId: String) async throws -> UserSettings?
} 