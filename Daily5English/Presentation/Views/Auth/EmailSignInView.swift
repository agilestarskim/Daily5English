//
//  EmailSignInView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct EmailSignInView: View {
    @StateObject private var viewModel: EmailSignInViewModel
    var authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        _viewModel = StateObject(wrappedValue: EmailSignInViewModel(authUseCase: authUseCase))
    }
    
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
            
            // 비밀번호 찾기 버튼
            HStack {
                Spacer()
                Button("비밀번호를 잊으셨나요?") {
                    // 비밀번호 찾기 로직
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.top, 4)
            
            Spacer()
            
            // 로그인 버튼
            Button(action: {
                Task {
                    await viewModel.login()
                }
            }) {
                Text("로그인")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .disabled(!viewModel.isFormValid)
            .padding(.top, 20)
            
            // 회원가입 링크
            HStack {
                Text("계정이 없으신가요?")
                    .foregroundColor(.gray)
                Button("회원가입") {
                    // 회원가입 화면으로 이동
                }
                .foregroundColor(.blue)
            }
            .font(.footnote)
            .padding(.top, 8)
            
            
        }
        .padding()
        .alert("로그인 오류", isPresented: $viewModel.showError) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }

    }
}
