//
//  AuthenticationUseCase.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation

final class AuthenticationUseCase: AuthenticationUseCaseProtocol {
    
    let repository: AuthenticationRepositoryProtocol
    
    init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUser() async throws -> User {
        return try await repository.getSession()
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        return try await repository.signUpWithEmail(email: email, password: password)
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        return try await repository.signInWithEmail(email: email, password: password)
    }
    
    func signInWithSocial() async throws -> User {
        return try await repository.signInWithSocial()
    }
    
    func signOut() async throws {
        return try await repository.signOut()
    }
    
    func withdrawal(userId: String) async throws {
        return try await repository.withdrawal(userId: userId)
    }
}
