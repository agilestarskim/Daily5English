import SwiftUI

struct LearnedWordsCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습한 단어")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                ScrollView {
                    LazyVStack(spacing: DSSpacing.xxSmall) {
                        ForEach(0..<5) { _ in
                            WordHistoryRow(
                                word: "Apple",
                                meaning: "사과",
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

private struct WordHistoryRow: View {
    let word: String
    let meaning: String
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: DSSpacing.xxxSmall) {
                Text(word)
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.primary)
                
                Text(meaning)
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            Spacer()
            
            Text(date)
                .font(DSTypography.caption)
                .foregroundColor(DSColors.Text.secondary)
        }
    }
} 