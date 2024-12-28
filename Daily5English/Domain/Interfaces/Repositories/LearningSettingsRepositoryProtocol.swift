//
//  LearningSettingsRepositoryProtocol.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

protocol LearningSettingsRepositoryProtocol {
    /// 학습 설정 업데이트
    func update(settings: LearningSettings) async throws
    /// 학습 설정 가져오기
    func fetch(userId: String) async throws -> LearningSettings?
}
