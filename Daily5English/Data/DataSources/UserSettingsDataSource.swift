import Foundation
import Supabase

protocol UserSettingsDataSource {
    func saveUserSettings(_ settings: UserSettingsDTO) async throws
    func getUserSettings(userId: String) async throws -> UserSettingsDTO?
}

class SupabaseUserSettingsDataSource: UserSettingsDataSource {
    private let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func saveUserSettings(_ settings: UserSettingsDTO) async throws {
        try await client
            .from("user_settings")
            .upsert(settings)
            .execute()
    }
    
    func getUserSettings(userId: String) async throws -> UserSettingsDTO? {
        let response = try await client
            .from("user_settings")
            .select()
            .eq("user_id", value: userId)
            .limit(1)
            .execute()
        
        let data: SupabaseResponse<UserSettingsDTO> = try SupabaseUtils.decode(response.data)

        return data.data.first
    }
} 
