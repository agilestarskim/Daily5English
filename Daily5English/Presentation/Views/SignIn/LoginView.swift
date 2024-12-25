//
//  LoginView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct LoginView: View {    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // 로고나 타이틀 영역
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                // 소셜 로그인 버튼들
                VStack(spacing: 12) {
                    NavigationLink(destination: EmailSignInView()) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white)
                            Text("이메일로 로그인")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .padding(.top, 8)
                    
                    // 카카오 로그인
                    Button(action: {
                        // 카카오 로그인 처리
                    }) {
                        HStack {
                            Image(systemName: "message.fill")
                                .foregroundColor(.black)
                            Text("카카오로 시작하기")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(12)
                    }
                    
                    // 구글 로그인
                    Button(action: {
                        // 구글 로그인 처리
                    }) {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .foregroundColor(.blue)
                            Text("Google로 시작하기")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // 애플 로그인
                    Button(action: {
                        // 애플 로그인 처리
                    }) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .foregroundColor(.white)
                            Text("Apple로 시작하기")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                
                // 이메일 로그인 링크
                NavigationLink(destination: EmailSignUpView()) {
                    Text("이메일로 회원가입")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .underline()
                }
                .padding(.top, 8)
                
                Spacer()
            }
            .background(Color.white)
        }
    }
}
