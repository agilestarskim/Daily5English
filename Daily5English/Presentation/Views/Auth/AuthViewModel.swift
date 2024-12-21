//
//  AuthViewModel.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import Foundation
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    private let authUsecase: AuthUseCase

    init(authUsecase: AuthUseCase) {
        self.authUsecase = authUsecase
    }

    func checkLoginStatus() async {
        do {
            let session = try await authUsecase.checkCurrentSession()
            isLoggedIn = session != nil
        } catch {
            print("Error checking login status: \(error)") // 에러 출력
            isLoggedIn = false
        }
    }
}
