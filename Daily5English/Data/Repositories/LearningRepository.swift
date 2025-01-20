import Foundation
import Supabase
import SwiftData

final class LearningRepository: LearningRepositoryProtocol {
    private let supabase: SupabaseClient
    private let userDefaults = UserDefaults.standard
    private let learnedWordsKey = "learnedWordsKey"
    
    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    // MARK: - Server Operations
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
    
    // 오늘 학습한 단어를 UserDefaults에 저장
    func saveWordsToUserDefaults(words: [Word]) {
        let wordData = words.map { try? JSONEncoder().encode($0) }
        userDefaults.set(wordData, forKey: learnedWordsKey)
    }
    
    // UserDefaults에서 오늘 학습한 단어를 로드
    func loadWordsFromUserDefaults() -> [Word] {
        guard let wordDataArray = userDefaults.array(forKey: learnedWordsKey) as? [Data] else {
            return []
        }
        return wordDataArray.compactMap { try? JSONDecoder().decode(Word.self, from: $0) }
    }
    
    // UserDefaults에서 저장된 단어를 초기화
    func clearWordsInUserDefaults() {
        userDefaults.removeObject(forKey: learnedWordsKey)
    }
    
    
}
