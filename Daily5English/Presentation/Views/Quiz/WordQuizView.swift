import SwiftUI

struct WordQuizView: View {
    @StateObject private var viewModel = WordQuizViewModel()
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            // 퀴즈 진행 상태
            ProgressBar(current: viewModel.currentQuestionIndex + 1, total: viewModel.totalQuestions)
                .padding(.horizontal)
            
            // 퀴즈 문제
            QuizQuestionCard(question: viewModel.currentQuestion)
            
            // 답변 옵션들
            VStack(spacing: DSSpacing.small) {
                ForEach(viewModel.currentOptions, id: \.self) { option in
                    DSButton(
                        title: option,
                        style: viewModel.selectedAnswer == option ? .primary : .secondary
                    ) {
                        viewModel.selectAnswer(option)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // 다음 문제 버튼
            if viewModel.showNextButton {
                DSButton(title: "다음 문제", action: viewModel.nextQuestion)
            }
        }
        .navigationTitle("단어 퀴즈")
        .padding()
    }
}

struct ProgressBar: View {
    let current: Int
    let total: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(DSColors.surface)
                
                Rectangle()
                    .frame(width: CGFloat(current) / CGFloat(total) * geometry.size.width)
                    .foregroundColor(DSColors.mainBlue)
            }
        }
        .frame(height: 8)
        .cornerRadius(4)
    }
}

struct QuizQuestionCard: View {
    let question: String
    
    var body: some View {
        DSCard {
            Text(question)
                .font(DSTypography.heading2)
                .foregroundColor(DSColors.Text.primary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
} 