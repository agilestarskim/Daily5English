//
//  LearningSettingsService.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

@Observable
final class LearningSettingService {
    
    var level: Level = .intermediate
    var count: Int = 9
    var category: Category = .business
    
    var error: LearningSettingError?
    
    private let learningSettingUseCase: LearningSettingUseCaseProtocol
    
    init(learningSettingUseCase: LearningSettingUseCaseProtocol) {
        self.learningSettingUseCase = learningSettingUseCase
    }
    
    func fetchLearningSetting(userId: String) async {
        do {
            guard let setting = try await learningSettingUseCase.fetch(userId: userId) else {
                self.error = LearningSettingError(id: "0000")
                return
            }
            
            self.level = setting.level
            self.count = setting.count
            self.category = setting.category
            
        } catch {
            self.error = LearningSettingError(id: "0000")
        }
    }
    
    func saveSetting(_ setting: LearningSetting?) async {
        guard let setting else { return } //TODO: 에러처리
        
        do {
            try await learningSettingUseCase.update(setting: setting)
        } catch {
            self.error = LearningSettingError(id: "0000")
        }
    }
}
