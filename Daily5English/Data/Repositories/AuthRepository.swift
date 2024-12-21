// Daily5English/Data/Repositories/AuthRepository.swift
import Foundation
import Supabase
import AuthenticationServices

class AuthRepository {
    private let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    // 현재 세션 확인 (비동기)
    func getCurrentSession() async throws -> Session? {
        let session = try await client.auth.session
        
        return session
    }
    
    // 이메일 회원가입
    func signUpWithEmail(email: String, password: String) async throws -> AuthResponse {
        return try await client.auth.signUp(email: email,password: password)
    }

    // 이메일 로그인
    func signInWithEmail(email: String, password: String) async throws -> Session {
        let session =  try await client.auth.signIn(email: email, password: password)
    
        return session
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}
