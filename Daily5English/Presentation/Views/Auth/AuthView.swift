//
//  EntryView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct AuthView: View {
    @State private var viewModel: AuthViewModel
    var authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        _viewModel = State(wrappedValue: AuthViewModel(authUseCase: authUseCase))
    }

    var body: some View {
        @Bindable var bViewModel = viewModel
        Group {
            if viewModel.isLoading {
                EmptyView()
            } else {
                if viewModel.isLoggedIn {
                    MainView()
                } else {
                    LoginView()
                }
                
            }
        }
        .task {
            await viewModel.checkLoginStatus()
        }
        .alert(item: $bViewModel.error) { error in
            Alert(title: Text(error.info.title), message: Text(error.info.description))
        }
        .environment(viewModel)
    }
}
