//
//  AuthError.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import Foundation

struct AuthError: Identifiable {
    var id: String    
    
    var info: (title:String, description: String) {
        switch self.id {
            case "0001": return ("로그인 에러", "ㅁㄴㅇㄹㅁㄴㅇ")
            case "0002": return ("회원가입 실패", "이메일 인증 처리 중 문제가 발생했습니다. 다시 시도해주세요.")
            case "0003": return ("계정이 존재하지 않습니다.", "이메일 또는 비밀번호를 다시 확인해주세요.")
            
        default:
            return ("로그인 에러", "")
        }
    }
}
