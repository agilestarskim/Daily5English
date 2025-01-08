import SwiftUI

struct MainTabView: View {
    @Environment(AuthenticationService.self) private var auth
    @Environment(LearningService.self) private var learning
    @Environment(LearningSettingService.self) private var setting
    @Environment(HomeDataService.self) private var homeData
    
    var body: some View {
        TabView {
            WordBookView()
                .tabItem {
                    Label("단어장", systemImage: "book.fill")
                }
            
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("프로필", systemImage: "person.fill")
                }
        }
        .task {
            if let userId = auth.currentUser?.id {
                setting.setUserId(userId)
                homeData.setUserId(userId)
                
                // 사용자 setting값을 서버에서 가져옴
                await setting.fetchLearningSetting()
                // 사용자 학습 통계를 서버에서 가져옴
                await homeData.fetchStatistics()
                // 학습 팁을 서버에서 가져옴
                await homeData.fetchTips()
                // 학습 기록 달력을 서버에서 가져옴
                await homeData.fetchLearningDates()
            }
        }
    }
} 
