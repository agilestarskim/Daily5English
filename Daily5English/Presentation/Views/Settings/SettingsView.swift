import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section("알림") {
                    NavigationLink("알림 설정") {
                        NotificationSettingsView()
                    }
                }
                
                Section("학습") {
                    NavigationLink("학습 설정") {
                        LearningSettingsView()
                    }
                }
                
                Section("계정") {
                    NavigationLink("계정 관리") {
                        AccountSettingsView()
                    }
                }
            }
            .navigationTitle("설정")
        }
    }
} 