//
//  LearningSettingsService.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

@Observable
final class LearningSettingService {
    
    var setting: LearningSetting = LearningSetting.defaults
    
    private(set) var userId: String? = nil
    
    var level: Level {
        self.setting.level
    }
    
    var count: Int {
        self.setting.count
    }
    
    var category: Category {
        self.setting.category
    }
    
    var error: LearningSettingError?
    
    private let learningSettingUseCase: LearningSettingUseCase
    
    init(learningSettingUseCase: LearningSettingUseCase) {
        self.learningSettingUseCase = learningSettingUseCase
    }
    
    //로그인 성공시 꼭 호출해야함.
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    func fetchLearningSetting() async {
        guard let userId else {
            self.error = LearningSettingError(id: "0000")
            return
        }
        
        do {
            let setting = try await learningSettingUseCase.fetch(userId: userId)
            self.setting = setting
            
        } catch {
            self.error = LearningSettingError(id: "0000")
        }
    }
    
    func update(_ setting: LearningSetting?) async {
        guard let setting else { return } //TODO: 에러처리
        
        do {
            try await learningSettingUseCase.update(setting: setting)
        } catch {
            self.error = LearningSettingError(id: "0000")
        }
    }
}
