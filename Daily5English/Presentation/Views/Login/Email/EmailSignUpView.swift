//
//  EmailSignUpView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct EmailSignUpView: View {
    @Environment(AuthenticationService.self) private var authService
    @StateObject private var viewModel = EmailSignUpViewModel()
        
    var body: some View {
        VStack(spacing: 20) {
            // 이메일 입력
            VStack(alignment: .leading, spacing: 8) {
                Text("이메일")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                TextField("이메일을 입력해주세요", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                
                if !viewModel.emailMessage.isEmpty {
                    Text(viewModel.emailMessage)
                        .font(.caption)
                        .foregroundColor(viewModel.isValidEmail ? .green : .red)
                }
            }
            
            // 비밀번호 입력
            VStack(alignment: .leading, spacing: 8) {
                Text("비밀번호")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                if !viewModel.passwordMessage.isEmpty {
                    Text(viewModel.passwordMessage)
                        .font(.caption)
                        .foregroundColor(viewModel.isValidPassword ? .green : .red)
                }
            }
            
            // 비밀번호 확인
            VStack(alignment: .leading, spacing: 8) {
                Text("비밀번호 확인")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                SecureField("비밀번호를 다시 입력해주세요", text: $viewModel.passwordConfirm)
                    .textFieldStyle(.roundedBorder)
                
                if !viewModel.passwordConfirmMessage.isEmpty {
                    Text(viewModel.passwordConfirmMessage)
                        .font(.caption)
                        .foregroundColor(viewModel.isValidPasswordConfirm ? .green : .red)
                }
            }
            
            Spacer()
            
            // 회원가입 버튼
            Button(action: {
                Task {
                    let email = viewModel.email
                    let password = viewModel.password
                    
                    await authService.signUpWithEmail(email: email, password: password)
                }
            }) {
                Text("회원가입")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .disabled(!viewModel.isFormValid)
        }
        .padding()        
    }
    
}

