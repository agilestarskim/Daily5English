import SwiftUI

struct LearningView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: DSSpacing.medium) {
                NavigationLink(destination: WordLearningView()) {
                    LearningModeCard(
                        title: "단어 학습",
                        description: "오늘의 단어를 학습해보세요",
                        iconName: "textformat"
                    )
                }
                
                NavigationLink(destination: SentenceLearningView()) {
                    LearningModeCard(
                        title: "문장 학습",
                        description: "실용적인 문장을 학습해보세요",
                        iconName: "text.quote"
                    )
                }
            }
            .padding()
            .navigationTitle("학습")
        }
    }
}

struct LearningModeCard: View {
    let title: String
    let description: String
    let iconName: String
    
    var body: some View {
        DSCard {
            HStack(spacing: DSSpacing.small) {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(DSColors.mainBlue)
                
                VStack(alignment: .leading, spacing: DSSpacing.xxSmall) {
                    Text(title)
                        .font(DSTypography.heading3)
                        .foregroundColor(DSColors.Text.primary)
                    
                    Text(description)
                        .font(DSTypography.body2)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
        }
    }
} 