//
//  LearningSettingsService.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

@Observable
final class LearningSettingsService {
    
    var difficulty: LearningSettings.Difficulty = .intermediate
    var dailyWordCount: Int = 9
    var category: LearningSettings.LearningCategory = .business
    
    var error: UserSettingsError?
    
    private let learningSettingsUseCase: LearningSettingsUseCaseProtocol
    
    init(learningSettingsUseCase: LearningSettingsUseCaseProtocol) {
        self.learningSettingsUseCase = learningSettingsUseCase
    }
    
    func fetchLearningSettings(userId: String) async {
        do {
            guard let settings = try await learningSettingsUseCase.fetch(userId: userId) else {
                self.error = UserSettingsError(id: "0000")
                return
            }
            
            self.difficulty = settings.difficulty
            self.dailyWordCount = settings.dailyWordCount
            self.category = settings.category
            
        } catch {
            self.error = UserSettingsError(id: "0000")
        }
    }
}
