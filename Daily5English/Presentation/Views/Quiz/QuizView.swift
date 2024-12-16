import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: DSSpacing.medium) {
                NavigationLink(destination: WordQuizView()) {
                    QuizTypeCard(
                        title: "단어 퀴즈",
                        description: "학습한 단어를 테스트해보세요",
                        iconName: "abc"
                    )
                }
                
                QuizResultsCard()
            }
            .padding()
            .navigationTitle("퀴즈")
        }
    }
}

struct QuizTypeCard: View {
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
                    
                    Text(description)
                        .font(DSTypography.body2)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
        }
    }
} 