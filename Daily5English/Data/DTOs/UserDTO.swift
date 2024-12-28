//
//  UserDTO.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation
import Auth

extension Auth.User {
    func toDomain() -> User {
        User(
            id: self.id.uuidString,
            nickname: self.userMetadata["nickname"]?.stringValue ?? "",
            email: self.email ?? "",
            isPremium: self.userMetadata["is_premium"]?.boolValue ?? false
        )
    }
}
