//
//  Daily5EnglishApp.swift
//  Daily5English
//
//  Created by 김민성 on 12/16/24.
//

import SwiftUI
import Supabase
@main
struct Daily5EnglishApp: App {
    @State private var authManager: AuthManager
    @State private var userSettingManager: UserSettingsManager
    
    let supabaseClient: SupabaseClient
    
    let authRepository: AuthRepository
    let authUseCase: AuthUseCase
    
    let userSettingsDataSource: UserSettingsDataSource
    let userSettingsRepository: UserSettingsRepository
    let userSettingsUseCase: UserSettingsUseCase
    
    
    init() {
        supabaseClient = {
            guard let url = URL(string: Config.supabaseURL ?? ""), let apiKey = Config.supabaseAPIKey else {
                fatalError("Supabase URL or API Key is missing in the Info.plist")
            }
            return SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
        }()
            
        
        authRepository = AuthRepository(client: supabaseClient)
        authUseCase = AuthUseCase(authRepository: authRepository)
        
        userSettingsDataSource = SupabaseUserSettingsDataSource(client: supabaseClient)
        userSettingsRepository = UserSettingsRepositoryImpl(dataSource: userSettingsDataSource)
        userSettingsUseCase = UserSettingsUseCase(repository: userSettingsRepository)
        
        _authManager = State(wrappedValue: AuthManager(useCase: authUseCase))
        _userSettingManager = State(wrappedValue: UserSettingsManager(useCase: userSettingsUseCase))
    }
    
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .onOpenURL { url in
                    supabaseClient.auth.handle(url)
                }
                .environment(authManager)
                .environment(userSettingManager)
        }
    }
}
