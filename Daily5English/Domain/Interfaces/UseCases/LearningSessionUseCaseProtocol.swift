protocol LearningSessionUseCaseProtocol {
    // 오늘의 학습 상태 확인
    func checkTodayLearningStatus(userId: String) async throws -> LearningStatus
    
    // 새로운 학습 세션 시작 (서버에서 단어 fetch 후 로컬에 세션 생성)
    func createSession(setting: LearningSetting) async throws -> LearningSession
    
    // SwiftData에서 현재 진행 중인 세션 가져오기
    func getCurrentSession(userId: String) throws -> LearningSession?
    
    // 단어 학습 진행 상태 업데이트 (SwiftData)
    func updateProgress(sessionId: String, lastStudiedWordIndex: Int) throws
    
    // 학습 세션 완료 (SwiftData)
    func completeSession(sessionId: String) throws
}
