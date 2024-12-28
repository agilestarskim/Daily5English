//
//  NotificationSettingsUseCaseProtocol.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

protocol NotificationSettingsUseCase {
    /// 알림 업데이트
    func updateNotificationSettings(newSettings: NotificationSettings) async throws
    
    /// 알림 가져오기
    func fetchNotificationSettings() async throws -> NotificationSettings
}
