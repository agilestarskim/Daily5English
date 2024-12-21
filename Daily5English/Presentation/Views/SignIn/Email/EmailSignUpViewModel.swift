//
//  EmailSignUpViewModel.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import Combine
import Foundation

class EmailSignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    @Published var emailMessage = ""
    @Published var passwordMessage = ""
    @Published var passwordConfirmMessage = ""    
    
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    @Published var isValidPasswordConfirm = false
    
    var isFormValid: Bool {
        isValidEmail && isValidPassword && isValidPasswordConfirm
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
                return self.isValidEmail ? "사용 가능한 이메일입니다." : "올바른 이메일 형식이 아닙니다."
            }
            .assign(to: &$emailMessage)
        
        // 비밀번호 유효성 검사
        $password
            .map { password -> Bool in
                let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~@$!%*#?&])[A-Za-z\\d~@$!%*#?&]{8,}$"
                let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
                return passwordPredicate.evaluate(with: password)
            }
            .assign(to: &$isValidPassword)
        
        $password
            .map { password -> String in
                if password.isEmpty {
                    return ""
                }
                return self.isValidPassword ? "사용 가능한 비밀번호입니다." : "영문, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다."
            }
            .assign(to: &$passwordMessage)
        
        // 비밀번호 확인 검사
        $passwordConfirm
            .map { passwordConfirm -> Bool in
                if passwordConfirm.isEmpty {
                    return false
                }
                return passwordConfirm == self.password
            }
            .assign(to: &$isValidPasswordConfirm)
        
        $passwordConfirm
            .map { passwordConfirm -> String in
                if passwordConfirm.isEmpty {
                    return ""
                }
                return self.isValidPasswordConfirm ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다."
            }
            .assign(to: &$passwordConfirmMessage)
    }
    
    
}
