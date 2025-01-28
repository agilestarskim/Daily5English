import Foundation
import Supabase
import SwiftData

final class LearningRepository: LearningRepositoryProtocol {
    private let supabase: SupabaseClient
    
    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func hasCompletedToday(userId: String) async throws -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        
        let learningStatistics: [LearningStatisticsDTO] = try await supabase
            .from("learning_statistics")
            .select()
            .eq("user_id", value: userId)
            .execute()
            .value
        
        if learningStatistics.isEmpty {
            return false
        }
        
        if let stat = learningStatistics.first, stat.lastLearningDate == today {
            return true
        } else {
            return false
        }
    }
    
    func fetchRandomWords(
        setting: LearningSetting,
        learnedWordIds: [Int]
    ) async throws -> [Word] {
        
        let settingDTO = LearningSettingDTO.toDTO(setting)
        let learnedWordIdsAsString: [String] = learnedWordIds.map(String.init)
        
        let wordDTOs: [WordDTO] = try await supabase
            .from("words")
            .select()
            .eq("category", value: settingDTO.categoryPreference)
            .eq("difficulty_level", value: settingDTO.difficultyLevel)
            .not("id", operator: .in, value: "(\(learnedWordIdsAsString.joined(separator: ",")))")
            .limit(settingDTO.dailyWordCount)
            .execute()
            .value
        
        let words: [Word] = wordDTOs.map { $0.toDomain() }
        
        return words
    }
    
    func saveLearnedWords(userId: String, wordIds: [Int]) async throws {
        let now = DateFormatter()
        now.dateFormat = "yyyy-MM-dd"
        let nowString = now.string(from: Date())
        
        let records = wordIds.map { wordId in
            [
                "user_id": AnyJSON.string(userId),
                "word_id": AnyJSON.integer(wordId),
                "learned_at": AnyJSON.string(nowString),
                "last_reviewed_at": AnyJSON.string(nowString),
                "reviewed_count": AnyJSON.integer(0)
            ]
        }
        
        try await supabase
            .from("learned_words")
            .upsert(records)
            .execute()
    }
    
    // 서버에서 오늘 학습한 단어를 가져오기
    func fetchLearnedWords(userId: String) async throws -> [Word] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())
        
        let learnedWordDTO: [LearnedWordDTO] = try await supabase
            .from("learned_words")
            .select("""
                word_id,
                reviewed_count,
                learned_at,
                last_reviewed_at,
                words (
                    id,
                    english,
                    korean,
                    part_of_speech,
                    example_sentence,
                    example_sentence_korean,
                    difficulty_level,
                    category
                )
            """)
            .eq("user_id", value: userId)
            .eq("learned_at", value: todayString)
            .order("learned_at", ascending: false)
            .execute()
            .value
        
        return learnedWordDTO.map { $0.toDomain().word }
    }
}
