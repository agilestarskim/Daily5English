import SwiftUI

struct LearnedSentencesCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습한 문장")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                ScrollView {
                    LazyVStack(spacing: DSSpacing.xxSmall) {
                        ForEach(0..<5) { _ in
                            SentenceHistoryRow(
                                sentence: "I love learning English.",
                                translation: "나는 영어 공부하는 것을 좋아합니다.",
                                date: "2024.03.16"
                            )
                        }
                    }
                }
            }
            .padding()
        }
    }
}

private struct SentenceHistoryRow: View {
    let sentence: String
    let translation: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.xxxSmall) {
            Text(sentence)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.primary)
            
            Text(translation)
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
            
            Text(date)
                .font(DSTypography.caption)
                .foregroundColor(DSColors.Text.secondary)
        }
    }
} 