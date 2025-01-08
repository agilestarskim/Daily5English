//
//  LearningTipRepository.swift
//  Daily5English
//
//  Created by 김민성 on 1/7/25.
//

import Foundation
import Supabase

final class HomeDataRepository {
    private let supabase: SupabaseClient

    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func updateLearningStatistics(userId: String, wordsCount: Int) async throws {
        try await supabase
            .rpc(
                "update_learning_completion",
                params: [
                    "_user_id": AnyJSON.string(userId),
                    "_words_count": AnyJSON.integer(wordsCount)
                ]
            )
            .execute()
    }
    
    func fetchLearningStatistics(userId: String) async throws -> LearningStatistics {
        let learningStatistics: LearningStatisticsDTO = try await supabase
            .from("learning_statistics")
            .select()
            .eq("user_id", value: userId)
            .single()
            .execute()
            .value
            
        return learningStatistics.toDomain()
    }
    
    func fetchLearningTips() async throws -> [LearningTip] {
        let LearningTips: [LearningTipDTO] = try await supabase
            .from("today_learning_tip_messages")
            .select()
            .execute()
            .value
        
        return LearningTips.map{ $0.toDomain() }
    }
}
