import SwiftUI

struct MainTabView: View {
    @Environment(AuthenticationService.self) private var auth
    @Environment(LearningService.self) private var learning
    @Environment(LearningSettingService.self) private var learningSetting
    
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
                learningSetting.setUserId(userId)
                
                // 사용자 setting값을 서버에서 가져옴
                await learningSetting.fetchLearningSetting()
            }
        }
    }
} 
