//
//  AuthenticationRepository.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation
import Supabase
import AuthenticationServices

final class AuthenticationRepository: AuthenticationRepositoryProtocol {
    
    private let supabase: SupabaseClient

    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func getSession() async throws -> User {
        let userDTO = try await supabase.auth.session.user
        
        return userDTO.toDomain()
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        let authResponse = try await supabase.auth.signUp(
            email: email,
            password: password,
            data: [
                "is_premium": .bool(false),
            ]
        )
        
        return authResponse.user.toDomain()
        
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        let session =  try await supabase.auth.signIn(email: email, password: password)
        
        return session.user.toDomain()
    }
    
    func signInWithSocial() async throws -> User {
        let session = try await supabase.auth.signInWithOAuth(
          provider: .github
        ) { (session: ASWebAuthenticationSession) in
          // customize session
        }
        
        return session.user.toDomain()
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
    }
    
    func withdrawal(userId: String) async throws {
        try await supabase.auth.admin.deleteUser(
            id: userId
        )
    }
}


