import SwiftUI

struct QuizResultsCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("최근 퀴즈 결과")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                HStack(spacing: DSSpacing.medium) {
                    StatItem(title: "정답률", value: "85%")
                    StatItem(title: "학습 단어", value: "32개")
                    StatItem(title: "연속 학습", value: "5일")
                }
            }
            .padding()
        }
    }
}

private struct StatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: DSSpacing.xxSmall) {
            Text(title)
                .font(DSTypography.caption)
                .foregroundColor(DSColors.Text.secondary)
            
            Text(value)
                .font(DSTypography.heading3)
                .foregroundColor(DSColors.mainBlue)
        }
    }
} 