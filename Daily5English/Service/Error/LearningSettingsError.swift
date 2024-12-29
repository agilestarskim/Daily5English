//
//  LearningSettingError.swift
//  Production
//
//  Created by 김민성 on 12/25/24.
//

import Foundation

struct LearningSettingError: Identifiable {
    var id: String
    
    var info: (title:String, description: String) {
        switch self.id {
            case "0001": return ("학습 설정 에러", "")
            
        default:
            return ("사용자 설정 에러", "")
        }
    }
}
