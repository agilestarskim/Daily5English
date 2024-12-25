//
//  EmailSignInViewModel.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import Foundation

class EmailSignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var emailMessage = ""
    
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    
    var isFormValid: Bool {
        isValidEmail && isValidPassword
    }
    
    init() {
        // 이메일 유효성 검사
        $email
            .map { email -> Bool in
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
                return emailPredicate.evaluate(with: email)
            }
            .assign(to: &$isValidEmail)
        
        $email
            .map { email -> String in
                if email.isEmpty {
                    return ""
                }
                return self.isValidEmail ? "" : "올바른 이메일 형식이 아닙니다."
            }
            .assign(to: &$emailMessage)
        
        // 비밀번호 유효성 검사
        $password
            .map { password -> Bool in
                return password.count >= 6
            }
            .assign(to: &$isValidPassword)
    }
}
