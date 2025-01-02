//
//  EntryView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct AuthView: View {
    @Environment(AuthenticationService.self) private var authService

    var body: some View {
        @Bindable var bAuthService = authService
        
        Group {
            if authService.isLoading {
                EmptyView()
            } else {
                if authService.isLoggedIn {
                    if authService.isFirstLaunch {
                        OnboardingView()
                    } else {
                        MainTabView()
                    }
                } else {
                    LoginView()
                }
            }
        }
        .task {
            await authService.checkLoginStatus()
        }
        .alert(item: $bAuthService.error) { error in
            Alert(
                title: Text(error.info.title),
                message: Text(error.info.description)
            )
        }
    }
}
