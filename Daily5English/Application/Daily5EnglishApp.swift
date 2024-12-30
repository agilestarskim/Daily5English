//
//  Daily5EnglishApp.swift
//  Daily5English
//
//  Created by 김민성 on 12/16/24.
//

import SwiftUI
import Supabase
import SwiftData

@main
struct Daily5EnglishApp: App {
    @State private var authenticationService: AuthenticationService
    @State private var learningSettingService: LearningSettingService
    @State private var learningService: LearningService
    
    let supabase: SupabaseClient
    
    init() {
        self.supabase = {
            guard let url = URL(string: Config.supabaseURL ?? ""),
                  let apiKey = Config.supabaseAPIKey
            else {
                fatalError("Supabase URL or API Key is missing in the Info.plist")
            }
            return SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
        }()
        
        // SwiftData 컨테이너 설정
        let modelContainer: ModelContainer = {
            let schema = Schema([
                LocalLearningSession.self,
                LocalQuizSession.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        // Authentication 설정
        let authRepo = AuthenticationRepository(supabase: supabase)
        let authUseCase = AuthenticationUseCase(repository: authRepo)
        let authService = AuthenticationService(authenticationUseCase: authUseCase)
        _authenticationService = State(wrappedValue: authService)
        
        // Learning Settings 설정
        let learningSettingRepo = LearningSettingRepository(supabase: supabase)
        let learningSettingUseCase = LearningSettingUseCase(repository: learningSettingRepo)
        let learningSettingService = LearningSettingService(learningSettingUseCase: learningSettingUseCase)
        _learningSettingService = State(wrappedValue: learningSettingService)
        
        // Learning Service 설정
        let learningRepo = LearningRepository(
            supabase: supabase,
            modelContext: modelContainer.mainContext
        )
        let learningSessionUseCase = LearningSessionUseCase(repository: learningRepo)
        let quizSessionUseCase = QuizSessionUseCase(repository: learningRepo)
        
        let learningService = LearningService(
            learningSessionUseCase: learningSessionUseCase,
            quizSessionUseCase: quizSessionUseCase,
            userId: authService.currentUser?.id ?? ""
        )
        _learningService = State(wrappedValue: learningService)
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .onOpenURL { url in
                    supabase.auth.handle(url)
                }
                .environment(authenticationService)
                .environment(learningSettingService)
                .environment(learningService)
        }
        .modelContainer(for: [LocalLearningSession.self, LocalQuizSession.self])
    }
}
