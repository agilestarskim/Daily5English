import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            LearningView()
                .tabItem {
                    Label("학습", systemImage: "book.fill")
                }
            
            QuizView()
                .tabItem {
                    Label("퀴즈", systemImage: "questionmark.circle.fill")
                }
            
            RecordView()
                .tabItem {
                    Label("기록", systemImage: "chart.bar.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("설정", systemImage: "gearshape.fill")
                }
        }
    }
} 