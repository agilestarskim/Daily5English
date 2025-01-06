//
//  LearningSettingRepository.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation
import Supabase

final class LearningSettingRepository: LearningSettingRepositoryProtocol {
    
    private let supabase: SupabaseClient

    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func update(setting: LearningSetting) async throws {
        let setting = LearningSettingDTO.toDTO(setting)
        
        try await supabase
            .from("user_settings")
            .upsert(setting)
            .execute()
    }
    
    func fetch(userId: String) async throws -> LearningSetting {        
        let settingDTO: LearningSettingDTO = try await supabase
            .from("user_settings")
            .select()
            .eq("user_id", value: userId)
            .limit(1)
            .single()
            .execute()
            .value
        
        return settingDTO.toDomain()
    }
}
