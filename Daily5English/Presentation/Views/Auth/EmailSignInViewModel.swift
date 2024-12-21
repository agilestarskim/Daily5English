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
    @Published var passwordMessage = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    
    private let authUseCase: AuthUseCase
    
    var isFormValid: Bool {
        isValidEmail && isValidPassword
    }
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        
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
                return self.isValidPassword ? "" : "비밀번호는 8자 이상이어야 합니다."
            }
            .assign(to: &$passwordMessage)
    }
    
    @MainActor
    func login() async {
        do {
            let session = try await authUseCase.signIn(email: email, password: password)
            print("로그인 시도:", session.user.email ?? "", session.expiresAt)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
