// Daily5English/Domain/UseCases/LoginUseCase.swift
import Foundation
import Supabase

class AuthUseCase {
    let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func checkCurrentSession() async throws -> Session? {
        return try await authRepository.getCurrentSession()
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
