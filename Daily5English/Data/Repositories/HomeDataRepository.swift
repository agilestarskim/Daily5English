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
    
    func fetchLearningDates(userId: String, year: Int, month: Int) async throws -> [Date] {
        let startOfMonth = Calendar.current.date(from: DateComponents(year: year, month: month))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let records: [LearningDateDTO] = try await supabase
            .from("learning_records")
            .select("learned_date")
            .eq("user_id", value: userId)
            .gte("learned_date", value: dateFormatter.string(from: startOfMonth))
            .lte("learned_date", value: dateFormatter.string(from: endOfMonth))
            .execute()
            .value
            
        return records.compactMap { 
            ISO8601DateFormatter().date(from: $0.learnedDate + "T00:00:00Z")
        }
    }
}
