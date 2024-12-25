//
//  UserManager.swift
//  Production
//
//  Created by 김민성 on 12/25/24.
//

import SwiftUI

@MainActor
@Observable
final class UserSettingsManager {
    var category: LearningCategory = .daily
    var dailyGoal: Int = 5
    var learningLevel: LearningLevel = .beginner
    
    var error: UserSettingsError? = nil
    
    private let userSettingsUseCase: UserSettingsUseCase
    
    init(useCase: UserSettingsUseCase) {
        self.userSettingsUseCase = useCase
    }
    
    func loadUserSettings(userId: String) async {
        do {
            if let settings = try await userSettingsUseCase.loadSettings(userId: userId) {
                self.learningLevel = settings.difficultyLevel
                self.category = settings.categoryPreference
                self.dailyGoal = settings.dailyWordCount
            }
        } catch {
            self.error = UserSettingsError(id: "0001")
        }
    }
    
    func saveUserSettings(userId: String?) async {
        guard let userId else { return }
        
        let settings = UserSettings(
            userId: userId,
            difficultyLevel: learningLevel,
            dailyWordCount: dailyGoal,
            categoryPreference: category
        )
        do {
            try await userSettingsUseCase.saveSettings(settings: settings)
        } catch {
            print("saveSettings failed: \(error.localizedDescription)")
        }
    }
}
