import Foundation
import Supabase
import SwiftData

final class LearningRepository: LearningRepositoryProtocol {
    private let supabase: SupabaseClient
    private let modelContext: ModelContext
    
    init(supabase: SupabaseClient, modelContext: ModelContext) {
        self.supabase = supabase
        self.modelContext = modelContext
    }
    
    // MARK: - Server Operations
    
    func fetchRandomWords(setting: LearningSetting) async throws -> [Word] {
        
        let settingDTO = LearningSettingDTO.toDTO(setting)
        
        let response: [Word] = try await supabase
            .from("words")
            .select()
            .eq("difficulty_level", value: settingDTO.difficultyLevel)
            .eq("category_preference", value: settingDTO.categoryPreference)
            .limit(settingDTO.dailyWordCount)
            .order("RANDOM()")
            .execute()
            .value
        
        return response
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
    
    // MARK: - Local Storage Operations (SwiftData)
    
    func saveLearningSession(_ session: LearningSession) throws {
        let localSession = LocalLearningSession(from: session)
        modelContext.insert(localSession)
        try modelContext.save()
    }
    
    func saveQuizSession(_ session: QuizSession) throws {
        let localSession = LocalQuizSession(from: session)
        modelContext.insert(localSession)
        try modelContext.save()
    }
    
    func getLearningSession(userId: String) throws -> LearningSession? {
        let calendar = Calendar.current
        let today = Date()
        let startOfDay = calendar.startOfDay(for: today)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<LocalLearningSession>(
            predicate: #Predicate<LocalLearningSession> { session in
                session.userId == userId && 
                session.date >= startOfDay &&
                session.date < endOfDay
            }
        )
        
        let localSession = try modelContext.fetch(descriptor).first
        return localSession?.toDomain()
    }
    
    func getQuizSession(userId: String) throws -> QuizSession? {
        let calendar = Calendar.current
        let today = Date()
        let startOfDay = calendar.startOfDay(for: today)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<LocalQuizSession>(
            predicate: #Predicate<LocalQuizSession> { session in
                session.userId == userId && 
                session.startTime >= startOfDay &&
                session.startTime < endOfDay
            }
        )
        
        let localSession = try modelContext.fetch(descriptor).first
        return localSession?.toDomain()
    }
    
    func updateLearningSession(_ session: LearningSession) throws {
        guard let localSession = try getLearningSessionLocal(id: session.id) else {
            throw LearningError.sessionNotFound
        }
        
        localSession.update(from: session)
        try modelContext.save()
    }
    
    func updateQuizSession(_ session: QuizSession) throws {
        guard let localSession = try getQuizSessionLocal(id: session.id) else {
            throw LearningError.sessionNotFound
        }
        
        localSession.update(from: session)
        try modelContext.save()
    }
    
    // MARK: - Private Helpers
    
    private func getLearningSessionLocal(id: String) throws -> LocalLearningSession? {
        let descriptor = FetchDescriptor<LocalLearningSession>(
            predicate: #Predicate<LocalLearningSession> { session in
                session.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
    
    private func getQuizSessionLocal(id: String) throws -> LocalQuizSession? {
        let descriptor = FetchDescriptor<LocalQuizSession>(
            predicate: #Predicate<LocalQuizSession> { session in
                session.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
} 
