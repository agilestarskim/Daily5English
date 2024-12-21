//
//  EntryView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel
    var authUseCase: AuthUseCase

    init(authUsecase: AuthUseCase) {
        self.authUseCase = authUsecase
        _viewModel = StateObject(wrappedValue: AuthViewModel(authUsecase: authUsecase))
    }

    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                MainTabView()
            } else {
                LoginView(authUseCase: authUseCase)
            }
        }
        .task {
            await viewModel.checkLoginStatus()
        }
    }
}
