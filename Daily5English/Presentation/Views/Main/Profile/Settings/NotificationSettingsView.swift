import SwiftUI


struct NotificationSettingsView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        List {
            Section {
                Toggle("학습 알림", isOn: $viewModel.isNotificationEnabled)
                
                if viewModel.isNotificationEnabled {
                    DatePicker("학습 시작 시간",
                             selection: $viewModel.learningStartTime,
                             displayedComponents: .hourAndMinute)
                    
                    DatePicker("복습 시작 시간",
                             selection: $viewModel.reviewStartTime,
                             displayedComponents: .hourAndMinute)
                }
            } footer: {
                Text("매일 설정한 시간에 학습 알림을 받습니다.")
            }
        }
        .navigationTitle("알림 설정")
    }
} 
