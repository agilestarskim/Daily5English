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
    @State private var homeDataService: HomeDataService
    @State private var wordBookService: WordBookService
    
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
        
        // WordBook Service 설정
        let wordBookRepo = WordBookRepository(supabase: supabase)
        let wordBookService = WordBookService(repository: wordBookRepo)
        _wordBookService = State(wrappedValue: wordBookService)
        
        // Learning Service 설정
        let learningRepo = LearningRepository(supabase: supabase)
        let learningUseCase = LearningUseCase(repository: learningRepo, wordBookRepository: wordBookRepo)
        let learningService = LearningService(learningUseCase: learningUseCase)
        _learningService = State(wrappedValue: learningService)
        
        // homeData Service 설정 (UseCase 없이 서비스에서 리포지토리로 바로 접근)
        let homeDataRepo = HomeDataRepository(supabase: supabase)
        let homeDataService = HomeDataService(repository: homeDataRepo)
        _homeDataService = State(wrappedValue: homeDataService)
        
        // 알림 설정
        Task {
            let isAuthorized = await NotificationManager.shared.requestAuthorization()
            if isAuthorized {
                let times = await NotificationManager.shared.getNotificationTimes()
                if let learningTime = times.learningTime {
                    NotificationManager.shared.updateLearningNotification(at: learningTime)
                } else {
                    // 기본 학습 알림 시간 설정
                    let defaultLearningTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
                    NotificationManager.shared.updateLearningNotification(at: defaultLearningTime)
                }
                
                if let reviewTime = times.reviewTime {
                    NotificationManager.shared.updateReviewNotification(at: reviewTime)
                } else {
                    // 기본 복습 알림 시간 설정
                    let defaultReviewTime = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
                    NotificationManager.shared.updateReviewNotification(at: defaultReviewTime)
                }
            }
        }
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
                .environment(homeDataService)
                .environment(wordBookService)
        }
    }
}
