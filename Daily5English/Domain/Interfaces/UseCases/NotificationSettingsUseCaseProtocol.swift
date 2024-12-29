//
//  NotificationSettingUseCaseProtocol.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

protocol NotificationsettingUseCase {
    /// 알림 업데이트
    func updateNotificationsetting(newsetting: NotificationSetting) async throws
    
    /// 알림 가져오기
    func fetchNotificationsetting() async throws -> NotificationSetting
}
