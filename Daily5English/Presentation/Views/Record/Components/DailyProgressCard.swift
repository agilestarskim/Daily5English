import SwiftUI

struct DailyProgressCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("오늘의 진행도")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                VStack(spacing: DSSpacing.xxSmall) {
                    ProgressRow(title: "단어", progress: 0.7)
                    ProgressRow(title: "문장", progress: 0.5)
                    ProgressRow(title: "퀴즈", progress: 0.3)
                }
            }
            .padding()
        }
    }
}

private struct ProgressRow: View {
    let title: String
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.xxxSmall) {
            Text(title)
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(DSColors.surface)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * progress)
                        .foregroundColor(DSColors.mainBlue)
                }
            }
            .frame(height: 8)
            .cornerRadius(4)
        }
    }
} 