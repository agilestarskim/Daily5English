//
//  LearningSettingsRepositoryProtocol.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

protocol LearningSettingRepositoryProtocol {
    /// 학습 설정 업데이트
    func update(setting: LearningSetting) async throws
    /// 학습 설정 가져오기
    func fetch(userId: String) async throws -> LearningSetting?
}
