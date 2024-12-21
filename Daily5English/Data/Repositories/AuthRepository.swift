// Daily5English/Data/Repositories/AuthRepository.swift
import Foundation
import Supabase
import AuthenticationServices

class AuthRepository {
    private let client: SupabaseClient
    private var user: User?

    init(client: SupabaseClient) {
        self.client = client
    }

    // 현재 세션 확인 (비동기)
    func getCurrentSession() async throws -> Session? {
        let session = try await client.auth.session
        
        saveUser(session) //세션 정보 저장
        return session
    }
    
    // 이메일 회원가입
    func signUpWithEmail(email: String, password: String) async throws -> AuthResponse {
        return try await client.auth.signUp(email: email,password: password)
    }

    // 이메일 로그인
    func signInWithEmail(email: String, password: String) async throws -> Session {
        let session =  try await client.auth.signIn(email: email, password: password)
        
        saveUser(session)
        return session
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        user = nil
    }
    
    // 회원정보 저장
    private func saveUser(_ session: Session?) {
        guard let session else { return }
        
        guard let email = session.user.email else { return }
        
        #if DEV
        print("AuthRepository: saveUser")
        #endif
        
        user = User(
            id: session.user.id,
            email: email
        )
        
    }
}
