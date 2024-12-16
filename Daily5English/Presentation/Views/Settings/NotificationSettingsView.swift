import SwiftUI

struct NotificationSettingsView: View {
    @State private var isEnabled = true
    @State private var selectedTime = Date()
    @State private var dailyReminder = true
    @State private var weeklyReport = true
    
    var body: some View {
        List {
            Section {
                Toggle("알림 활성화", isOn: $isEnabled)
                
                if isEnabled {
                    DatePicker(
                        "알림 시간",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }
            
            Section("알림 유형") {
                Toggle("일일 학습 알림", isOn: $dailyReminder)
                Toggle("주간 리포트", isOn: $weeklyReport)
            }
        }
        .navigationTitle("알림 설정")
    }
} 
