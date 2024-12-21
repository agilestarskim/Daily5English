// Daily5English/Domain/UseCases/LoginUseCase.swift
import Foundation
import Supabase

class AuthUseCase {
    let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func checkCurrentSession() async throws -> Session? {
        let session = try await authRepository.getCurrentSession()
        
        #if DEV
        if let session {
            print("로그인 성공")
            print("이메일 정보: ", session.user.email ?? "")
            print("토큰 만료: ",  Date(timeIntervalSinceNow: session.expiresAt).formatted())
            print("이메일 인증날짜: " ,  session.user.emailConfirmedAt?.formatted() ?? "")
        }
        #endif
        
        return session
    }
    
    func signUp(email: String, password: String) async throws -> AuthResponse {
        return try await authRepository.signUpWithEmail(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws -> Session {
        return try await authRepository.signInWithEmail(email: email, password: password)
    }
    
    func signOut() async throws {
        try await authRepository.signOut()
    }
}
