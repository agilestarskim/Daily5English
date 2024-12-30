import SwiftUI

@Observable
final class LearningService {
    // MARK: - Properties
    private(set) var learningStatus: LearningStatus = .notStarted
    private(set) var currentLearningSession: LearningSession?
    private(set) var currentQuizSession: QuizSession?
    private(set) var isLoading = false
    private(set) var error: Error?
    
    private let learningSessionUseCase: LearningSessionUseCase
    private let quizSessionUseCase: QuizSessionUseCase
    private let userId: String
    
    // MARK: - Init
    init(
        learningSessionUseCase: LearningSessionUseCase,
        quizSessionUseCase: QuizSessionUseCase,
        userId: String
    ) {
        self.learningSessionUseCase = learningSessionUseCase
        self.quizSessionUseCase = quizSessionUseCase
        self.userId = userId
    }
    
    // MARK: - Public Methods
    
    /// 오늘의 학습 상태 체크
    @MainActor
    func checkTodayLearningStatus() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let status = try await learningSessionUseCase.checkTodayLearningStatus(userId: userId)
            self.learningStatus = status
            if case .inProgress(let session) = status {
                self.currentLearningSession = session
            }
        } catch {
            self.error = error
        }
    }
    
    /// 새로운 학습 세션 시작
    @MainActor
    func startLearningSession(setting: LearningSetting) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let session = try await learningSessionUseCase.createSession(setting: setting)
            self.currentLearningSession = session
            self.learningStatus = .inProgress(session)
        } catch {
            self.error = error
        }
    }
    
    /// 단어 학습 진행 상태 업데이트
    func updateLearningProgress(lastStudiedWordIndex: Int) {
        guard let session = currentLearningSession else { return }
        
        do {
            try learningSessionUseCase.updateProgress(
                sessionId: session.id,
                lastStudiedWordIndex: lastStudiedWordIndex
            )
        } catch {
            self.error = error
        }
    }
    
    /// 단어 학습 완료 및 퀴즈 세션 시작
    @MainActor
    func completeLearningAndStartQuiz() async {
        guard let learningSession = currentLearningSession else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            // 학습 세션 완료
            try learningSessionUseCase.completeSession(sessionId: learningSession.id)
            
            // 퀴즈 세션 시작
            let quizSession = try await quizSessionUseCase.createSession(
                userId: userId,
                learningSession: learningSession
            )
            self.currentQuizSession = quizSession
        } catch {
            self.error = error
        }
    }
    
    /// 퀴즈 답변 제출
    func submitQuizAnswer(quizIndex: Int, isCorrect: Bool) {
        guard let session = currentQuizSession else { return }
        
        do {
            try quizSessionUseCase.submitAnswer(
                sessionId: session.id,
                quizIndex: quizIndex,
                isCorrect: isCorrect
            )
        } catch {
            self.error = error
        }
    }
    
    /// 퀴즈 세션 완료
    @MainActor
    func completeQuizSession() async -> LearningStatistics? {
        guard let session = currentQuizSession else { return nil }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let statistics = try await quizSessionUseCase.completeSession(sessionId: session.id)
            self.currentQuizSession = nil
            self.learningStatus = .completed
            return statistics
        } catch {
            self.error = error
            return nil
        }
    }
    
    /// 에러 초기화
    func clearError() {
        error = nil
    }
} 
