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
    
    func fetchQuizzes(words: [Word]) async throws -> [Quiz] {
        // 서버에 퀴즈 생성 요청
        let response: [Quiz] = try await supabase
            .from("generate_quizzes")
            .select()
            .execute()
            .value
        
        return response
    }
    
    func saveLearningStatistics(_ statistics: LearningStatistics) async throws {
        try await supabase
            .from("learning_statistics")
            .insert(statistics)
            .execute()
    }
} 
