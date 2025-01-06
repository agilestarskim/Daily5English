import SwiftUI

struct MainTabView: View {
    @Environment(AuthenticationService.self) private var auth
    @Environment(LearningService.self) private var learning
    @Environment(LearningSettingService.self) private var setting
    
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
                learning.setUserId(userId)
                
                // 사용자 setting값을 서버에서 가져옴
                await setting.fetchLearningSetting()
                // 사용자 학습 통계를 서버에서 가져옴
                await learning.fetchStatistics()
            }
        }
    }
} 
