//
//  UserProfileUseCaseProtocol.swift
//  Production
//
//  Created by 김민성 on 12/27/24.
//

import Foundation

protocol UserProfileUseCase {
    /// 유저 프로필 변경
    func updateProfile(newUser: User) async throws -> User
    
    /// 비밀번호 변경
    func updatePassword(currentPassword: String, newPassword: String) async throws
    
    /// 유저정보 가져오기
    func fetchUserProfile() async throws -> User
}
