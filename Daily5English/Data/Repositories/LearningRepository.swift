import Foundation
import Supabase
import SwiftData

final class LearningRepository: LearningRepositoryProtocol {
    private let supabase: SupabaseClient
    
    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    // MARK: - Server Operations
    
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word] {
        
        let settingDTO = LearningSettingDTO.toDTO(setting)
        
        let wordDTOs: [WordDTO] = try await supabase
            .from("words")
            .select()
            .eq("category", value: settingDTO.categoryPreference)
            .eq("difficulty_level", value: settingDTO.difficultyLevel)
            .limit(settingDTO.dailyWordCount)
            .execute()
            .value
        
        let words: [Word] = wordDTOs.map { $0.toDomain() }
        
        return words
    }
    
    func updateLearningCompletion(userId: String, wordsCount: Int) async throws {
        let result = try await supabase
            .rpc(
                "update_learning_completion",
                params: [
                    "_user_id": AnyJSON.string(userId),
                    "_words_count": AnyJSON.integer(wordsCount)
                ]
            )
            .execute()
        
        print(result.response.allHeaderFields)
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
}
