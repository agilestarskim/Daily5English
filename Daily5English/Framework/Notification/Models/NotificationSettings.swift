//
//  NotificationSetting.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

struct NotificationSettings {
    var learningTime: Date
    var reviewTime: Date
    
    static let defaultSettings = NotificationSettings(
        learningTime: Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!,
        reviewTime: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
    )
}
