//
//  EntryView.swift
//  Production
//
//  Created by 김민성 on 12/21/24.
//

import SwiftUI

struct AuthView: View {
    @Environment(AuthManager.self) private var authManager

    var body: some View {
        @Bindable var bAuthManager = authManager
        Group {
            if authManager.isLoading {
                EmptyView()
            } else {
                if authManager.isLoggedIn {
                    if authManager.isFirstLaunch {
                        OnboardingView()
                    } else {
                        MainView()
                    }
                } else {
                    LoginView()
                }
            }
        }
        .task {
            await authManager.checkLoginStatus()
        }
        .alert(item: $bAuthManager.error) { error in
            Alert(
                title: Text(error.info.title),
                message: Text(error.info.description)
            )
        }
    }
}
