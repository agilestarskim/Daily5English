import SwiftUI


@Observable final class UserSettingsManager {
    private let useCase: UserSettingsUseCase
    private var lastFetchTime: Date?
    private let cacheValidDuration: TimeInterval = 300 // 5분
    
    // 캐시된 설정값들
    var learningLevel: LearningLevel = .beginner
    var category: LearningCategory = .daily
    var dailyGoal: Int = 5
    
    init(useCase: UserSettingsUseCase) {
        self.useCase = useCase
    }
    
    func loadUserSettings(userId: String?) async {
        guard let userId = userId else { return }
        
        // 캐시가 유효한지 확인
        if let lastFetch = lastFetchTime,
           Date().timeIntervalSince(lastFetch) < cacheValidDuration {
            // 캐시가 유효하면 서버 호출 스킵
            return
        }
        
        do {
            if let settings = try await useCase.loadSettings(userId: userId) {
                // 설정값 업데이트
                await MainActor.run {
                    self.learningLevel = settings.difficultyLevel
                    self.category = settings.categoryPreference
                    self.dailyGoal = settings.dailyWordCount
                    self.lastFetchTime = Date()
                }
            }
        } catch {
            print("Failed to load user settings: \(error)")
        }
    }
    
    func saveUserSettings(userId: String?) async {
        guard let userId = userId else { return }
        
        do {
            let settings = UserSettings(
                userId: userId,
                difficultyLevel: learningLevel,
                dailyWordCount: dailyGoal,
                categoryPreference: category
            )
            try await useCase.saveSettings(settings: settings)
            
            // 저장 성공 시 캐시 시간 업데이트
            await MainActor.run {
                self.lastFetchTime = Date()
            }
        } catch {
            print("Failed to save user settings: \(error)")
        }
    }
    
    // 캐시를 강제로 무효화하고 새로 로드
    func refreshUserSettings(userId: String?) async {
        lastFetchTime = nil
        await loadUserSettings(userId: userId)
    }
} 
