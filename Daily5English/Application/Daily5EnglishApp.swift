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
    
    @State private var authenticationService: AuthenticationService
    @State private var learningSettingsService: LearningSettingsService
    
    let supabaseClient: SupabaseClient
    
    let authenticationRepository: AuthenticationRepositoryProtocol
    let authenticationUseCase: AuthenticationUseCaseProtocol
    
    let learningSettingsRepository: LearningSettingsRepositoryProtocol
    let learningSettingsUseCase: LearningSettingsUseCaseProtocol
    
    init() {
        //New
        supabaseClient = {
            guard let url = URL(string: Config.supabaseURL ?? ""), let apiKey = Config.supabaseAPIKey else {
                fatalError("Supabase URL or API Key is missing in the Info.plist")
            }
            return SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
        }()
        
        authenticationRepository = AuthenticationRepository(supabase: supabaseClient)
        authenticationUseCase = AuthenticationUseCase(repository: authenticationRepository)
        let authenticationService = AuthenticationService(authenticationUseCase: authenticationUseCase)
        _authenticationService = State(wrappedValue: authenticationService)
        
        
        learningSettingsRepository = LearningSettingsRepository(supabase: supabaseClient)
        learningSettingsUseCase = LearningSettingsUseCase(repository: learningSettingsRepository)
        let learningSettingsService = LearningSettingsService(learningSettingsUseCase: learningSettingsUseCase)
        _learningSettingsService = State(wrappedValue: learningSettingsService)
    }
    
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .onOpenURL { url in
                    supabaseClient.auth.handle(url)
                }
                .environment(authenticationService)
                .environment(learningSettingsService)
        }
    }
}
