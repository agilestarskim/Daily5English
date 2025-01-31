import SwiftUI

struct NotificationSettingsView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 24) {
            DatePicker("학습 알림 시간", selection: $viewModel.learningStartTime, displayedComponents: .hourAndMinute)
            
            DatePicker("복습 알림 시간", selection: $viewModel.reviewStartTime, displayedComponents: .hourAndMinute)
            
            Button(action: {
                NotificationManager.shared.updateLearningNotification(at: viewModel.learningStartTime)
                NotificationManager.shared.updateReviewNotification(at: viewModel.reviewStartTime)
                
                // 저장 후 이전 화면으로 돌아가기
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("저장")
                    .font(DSTypography.body1Bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(DSColors.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .background(DSColors.background.ignoresSafeArea())
        .navigationTitle("알림 설정")
    }
} 
