import SwiftUI

struct MainTabView: View {
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
    }
} 