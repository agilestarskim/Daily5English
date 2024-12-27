import SwiftUI

struct LearningView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                VStack {
                    Text("학습 화면")
                        .font(DSTypography.heading2)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("그만하기") {
                        dismiss()
                    }
                    .foregroundColor(DSColors.Text.primary)
                }
            }
        }
    }
} 