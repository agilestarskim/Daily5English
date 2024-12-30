protocol QuizSessionUseCaseProtocol {
    // 학습 세션에 대한 퀴즈 세션 생성 (서버에서 퀴즈 fetch 후 로컬에 세션 생성)
    func createSession(userId: String, learningSession: LearningSession) async throws -> QuizSession
    
    // SwiftData에서 현재 진행 중인 퀴즈 세션 가져오기
    func getCurrentSession(userId: String) throws -> QuizSession?
    
    // 퀴즈 답변 제출 및 결과 업데이트 (SwiftData)
    func submitAnswer(sessionId: String, quizIndex: Int, isCorrect: Bool) throws
    
    // 퀴즈 세션 완료 및 통계 생성 (SwiftData + 서버 저장)
    func completeSession(sessionId: String) async throws -> LearningStatistics
} 
