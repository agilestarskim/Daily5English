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
    
    func saveLearnedWords(userId: String, wordIds: [Int]) async throws {
        let now = ISO8601DateFormatter().string(from: Date())
        let records = wordIds.map { wordId in
            [
                "user_id": AnyJSON.string(userId),
                "word_id": AnyJSON.integer(wordId),
                "learned_at": AnyJSON.string(now),
                "last_reviewed_at": AnyJSON.string(now),
                "reviewed_count": AnyJSON.integer(0)
            ]
        }
        
        try await supabase
            .from("learned_words")
            .upsert(records)
            .execute()
    }
}
