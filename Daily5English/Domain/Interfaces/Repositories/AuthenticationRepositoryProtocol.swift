//
//  AuthenticationRepositoryProtocol.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

protocol AuthenticationRepositoryProtocol {    
    /// 로그인 세션 정보를 가져온다.
    func getSession() async throws -> User
    
    /// 이메일 회원가입
    func signUpWithEmail(email: String, password: String) async throws -> User
    
    /// 이메일 로그인
    func signInWithEmail(email: String, password: String) async throws -> User
    
    /// 소셜 로그인
    func signInWithSocial() async throws -> User
    
    /// 로그아웃
    func signOut() async throws
    
    ///회원탈퇴
    func withdrawal(userId: String) async throws
}
