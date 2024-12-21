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
    let supabaseClient: SupabaseClient
    let authRepository: AuthRepository
    let authUsecase: AuthUseCase
    
    init() {
        supabaseClient = {
            guard let url = URL(string: Config.supabaseURL ?? ""), let apiKey = Config.supabaseAPIKey else {
                fatalError("Supabase URL or API Key is missing in the Info.plist")
            }
            return SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
        }()
            
        // AuthRepository와 LoginUseCase 초기화
        authRepository = AuthRepository(client: supabaseClient)
        authUsecase = AuthUseCase(authRepository: authRepository)
    }
    
    
    var body: some Scene {
        WindowGroup {
            AuthView(authUseCase: authUsecase)
                .onOpenURL { url in
                    supabaseClient.auth.handle(url)
                }
        }
    }
}
