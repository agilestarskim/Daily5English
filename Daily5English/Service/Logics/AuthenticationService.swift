//
//  AuthenticationService.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import SwiftUI

@MainActor
@Observable
final class AuthenticationService {
    private(set) var isLoading: Bool = true
    private(set) var isLoggedIn: Bool = false
    private(set) var currentUser: User? = nil
    private(set) var isFirstLaunch: Bool = true
    
    var error: AuthError? = nil
    
    private let authenticationUseCase: AuthenticationUseCaseProtocol
    
    init(authenticationUseCase: AuthenticationUseCaseProtocol) {
        self.authenticationUseCase = authenticationUseCase
    }
    
    func checkLoginStatus() async {
        isLoading = true
        
        do {
            self.currentUser = try await authenticationUseCase.getUser()
            
            self.isLoading = false
            self.isLoggedIn = true
            
            #if DEV
            if let user = self.currentUser {
                print("------------세션 정보 로딩 성공------------")
                print("이메일 정보: ", user.email)
                print("마지막 로그인",  user.lastSignInAt ?? "")
                print("닉네임", user.nickname ?? "")
                print("프리미엄 여부", user.isPremium ?? "")
                print("--------------------------------------")
            }
            #endif
            
        } catch {
            self.isLoading = false
            self.isLoggedIn = false
            self.currentUser = nil
        }
    }
    
    func signUpWithEmail(email: String, password: String) async {
        do {
            let _ = try await authenticationUseCase.signUpWithEmail(
                email: email,
                password: password
            )
            
            await checkLoginStatus()
        } catch {
            self.error = AuthError(id: "0002")
        }
    }
    
    func signInWithEmail(email: String, password: String) async {
        do {
            self.currentUser = try await authenticationUseCase.signInWithEmail(
                email: email,
                password: password
            )
            
            self.isLoading = false
            self.isLoggedIn = true
            
            #if DEV
            if let user = self.currentUser {
                print("------------로그인 성공------------")
                print("이메일 정보: ", user.email)
                print("마지막 로그인",  user.lastSignInAt ?? "")
                print("닉네임", user.nickname)
                print("프리미엄 여부", user.isPremium)
                print("--------------------------------------")
            }
            #endif
            
        } catch {
            self.error = AuthError(id: "0003")
        }
    }
    
    func signOut() async {
        do {
            try await authenticationUseCase.signOut()
            
            self.isLoading = false
            self.isLoggedIn = false
            self.currentUser = nil
        } catch {
            self.error = AuthError(id: "0004")
        }
    }
    
    func completeOnboarding() {
        self.isFirstLaunch = false
    }
}
