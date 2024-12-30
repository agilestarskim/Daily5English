import Foundation

final class LearningSessionUseCase: LearningSessionUseCaseProtocol {
    
    private let repository: LearningRepository
    
    init(repository: LearningRepository) {
        self.repository = repository
    }
    
    func checkTodayLearningStatus(userId: String) async throws -> LearningStatus {
        if let currentSession = try repository.getLearningSession(userId: userId) {
            return currentSession.isCompleted ? .completed : .inProgress(currentSession)
        }
        return .notStarted
    }
    
    func createSession(setting: LearningSetting) async throws -> LearningSession {
        // 설정된 개수만큼 랜덤 단어 가져오기
        let words = try await repository.fetchRandomWords(setting: setting)
        
        // 새로운 학습 세션 생성
        let session = LearningSession(
            id: UUID().uuidString,
            userId: setting.userId,
            date: Date(),
            words: words,
            isCompleted: false,
            lastStudiedWordIndex: 0
        )
        
        // SwiftData에 저장
        try repository.saveLearningSession(session)
        return session
    }
    
    func getCurrentSession(userId: String) throws -> LearningSession? {
        try repository.getLearningSession(userId: userId)
    }
    
    func updateProgress(sessionId: String, lastStudiedWordIndex: Int) throws {
        guard var session = try repository.getLearningSession(userId: sessionId) else {
            throw LearningError.sessionNotFound
        }
        
        session.lastStudiedWordIndex = lastStudiedWordIndex
        try repository.updateLearningSession(session)
    }
    
    func completeSession(sessionId: String) throws {
        guard var session = try repository.getLearningSession(userId: sessionId) else {
            throw LearningError.sessionNotFound
        }
        
        session.isCompleted = true
        try repository.updateLearningSession(session)
    }
} 
