//
//  LearningSettingsRepository.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation
import Supabase

final class LearningSettingsRepository: LearningSettingsRepositoryProtocol {
    
    private let supabase: SupabaseClient

    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func update(settings: LearningSettings) async throws {
        try await supabase
            .from("user_settings")
            .upsert(settings)
            .execute()
    }
    
    func fetch(userId: String) async throws -> LearningSettings? {        
        let response: PostgrestResponse<LearningSettingsDTO> = try await supabase
            .from("user_settings")
            .select()
            .eq("user_id", value: userId)
            .limit(1)
            .single()
            .execute()
        
        let learningSettingsDTO: LearningSettingsDTO? = try SupabaseUtils.decode(response)
        
        return learningSettingsDTO?.toDomain()

    }
}
