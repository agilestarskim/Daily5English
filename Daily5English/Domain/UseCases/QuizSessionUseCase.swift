import Foundation

final class QuizSessionUseCase {
    private let repository: LearningRepository
    
    init(repository: LearningRepository) {
        self.repository = repository
    }
    
//    func createSession(userId: String, learningSession: LearningSession) async throws -> QuizSession {
//        // 학습한 단어들로 퀴즈 생성 요청
//        let quizzes = try await repository.fetchQuizzes(words: learningSession.words)
//        
//        // 새로운 퀴즈 세션 생성
//        let session = QuizSession(
//            id: UUID().uuidString,
//            userId: userId,
//            learningSessionId: learningSession.id,
//            startTime: Date(),
//            endTime: nil,
//            quizzes: quizzes,
//            currentQuizIndex: 0,
//            correctCount: 0,
//            isCompleted: false
//        )
//        
//        // SwiftData에 저장
//        try repository.saveQuizSession(session)
//        return session
//    }
//    
//    func getCurrentSession(userId: String) throws -> QuizSession? {
//        try repository.getQuizSession(userId: userId)
//    }
//    
//    func submitAnswer(sessionId: String, quizIndex: Int, isCorrect: Bool) throws {
//        guard var session = try repository.getQuizSession(userId: sessionId) else {
//            throw LearningError.sessionNotFound
//        }
//        
//        session.currentQuizIndex = quizIndex + 1
//        if isCorrect {
//            session.correctCount += 1
//        }
//        
//        try repository.updateQuizSession(session)
//    }
//    
//    func completeSession(sessionId: String) async throws -> LearningStatistics {
//        guard var session = try repository.getQuizSession(userId: sessionId) else {
//            throw LearningError.sessionNotFound
//        }
//        
//        session.isCompleted = true
//        session.endTime = Date()
//        try repository.updateQuizSession(session)
//        
//        // 학습 통계 생성
//        let statistics = LearningStatistics(
//            userId: session.userId,
//            date: Date.now,
//            totalWordsLearned: 0,
//            learningTime: .nan,
//            streakDays: 0,
//            completedSessions: 0
//        )
//        
//        // 서버에 통계 저장
//        try await repository.saveLearningStatistics(statistics)
//        return statistics
//    }
} 
