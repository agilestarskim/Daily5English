//
//  AuthManager.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import Foundation
import SwiftUI
import Supabase

@MainActor
@Observable
final class AuthManager {
    var isLoading: Bool = true
    var isLoggedIn: Bool = false
    var error: AuthError? = nil
    var currentUser: User? = nil
    var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") == false
    
    private let authUseCase: AuthUseCase

    init(useCase: AuthUseCase) {
        self.authUseCase = useCase
    }

    func checkLoginStatus() async {
        isLoading = true
        
        do {
            let session = try await authUseCase.checkCurrentSession()
            self.isLoading = false
            self.isLoggedIn = session != nil
            saveUser(session)
            
            #if DEV
            if let session {
                print("------------세션 정보 로딩 성공------------")
                print("이메일 정보: ", session.user.email ?? "")
                print("토큰 만료: ",  Date(timeIntervalSinceNow: session.expiresAt).formatted())
                print("이메일 인증날짜: " ,  session.user.emailConfirmedAt?.formatted() ?? "")
                print("메타데이터:", session.user.userMetadata)
                print("--------------------------------------")
            }
            #endif            
        } catch {
            isLoading = false
            isLoggedIn = false
            currentUser = nil
        }
    }
    
    func signUpWithEmail(email: String, password: String) async {
        do {
            let authResponse = try await authUseCase.signUp(email: email, password: password)
            #if DEV
            if let session = authResponse.session {
                print("--------------회원가입 성공--------------")
                print("이메일 정보: ", session.user.email ?? "")
                print("토큰 만료: ",  Date(timeIntervalSinceNow: session.expiresAt).formatted())
                print("이메일 인증날짜: " ,  session.user.emailConfirmedAt?.formatted() ?? "")
                print("--------------------------------------")
            }
            #endif
            self.error = AuthError(id: "1000")
            await checkLoginStatus()
        } catch {
            self.error = AuthError(id: "0002")
        }
    }
    
    func signInWithEmail(email: String, password: String) async {
        do {
            let session = try await authUseCase.signIn(email: email, password: password)
            #if DEV
            print("--------------로그인 성공--------------")
            print("이메일 정보: ", session.user.email ?? "")
            print("토큰 만료: ",  Date(timeIntervalSinceNow: session.expiresAt).formatted())
            print("이메일 인증날짜: " ,  session.user.emailConfirmedAt?.formatted() ?? "")
            print("--------------------------------------")
            #endif
            await checkLoginStatus()
        } catch {
            self.error = AuthError(id: "0003")
        }
    }
    
    func signOut() async {
        do {
            _ = try await authUseCase.signOut()
            #if DEV            
            print("--------------로그아웃 성공--------------")
            print("로그아웃 날짜: ", Date.now.formatted())
            print("--------------------------------------")
            #endif
            await checkLoginStatus()
        } catch {
            self.error = AuthError(id: "0004")
        }
    }
    
    // 회원정보 저장
    private func saveUser(_ session: Session?) {
        guard let session else { return }
        
        guard let email = session.user.email else { return }
        
        currentUser = User(
            id: session.user.id.uuidString,
            email: email
        )
    }
    
    func completeOnboarding() {
//        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        isFirstLaunch = false
    }
}
