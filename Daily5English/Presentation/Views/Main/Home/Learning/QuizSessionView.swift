import SwiftUI

struct QuizSessionView: View {
    @Environment(LearningContainerViewModel.self) private var learningContainerViewModel
    @Environment(QuizSessionViewModel.self) private var viewModel
    
    var body: some View {
        VStack(spacing: 24) {
            // 진행 상태
            ProgressView(value: viewModel.quizProgress)
                .tint(DSColors.accent)
                .padding(.horizontal)
            
            Text("\(viewModel.currentQuizNumber)/\(viewModel.totalQuizCount)")
                .font(DSTypography.caption1)
                .foregroundColor(DSColors.Text.secondary)
            
            Spacer()
            
            // 퀴즈 타입 표시
            Text(viewModel.quizTypeText)
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(DSColors.surface)
                .clipShape(Capsule())
            
            // 퀴즈 문제
            Text(viewModel.currentQuiz.question)
                .font(DSTypography.heading2)
                .foregroundColor(DSColors.Text.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            // 보기 선택지
            VStack(spacing: 12) {
                ForEach(viewModel.currentQuiz.options, id: \.self) { option in
                    Button {
                        withAnimation(.spring(response: 0.1)) {
                            viewModel.selectedOption = option
                            viewModel.showFeedback = true
                        }
                    } label: {
                        HStack {
                            Text(option)
                                .font(DSTypography.body1)
                                .foregroundColor(optionTextColor(for: option))
                            
                            Spacer()
                            
                            if viewModel.selectedOption == option {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(DSColors.accent)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding()
                        .background(optionBackground(for: option))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .scaleEffect(viewModel.selectedOption == option ? 1.02 : 1.0)
                    }
                    .disabled(viewModel.showFeedback)
                }
            }
            .padding(.horizontal)
            .animation(.smooth, value: viewModel.selectedOption)
            
            // 다음 버튼
            if viewModel.showFeedback {
                Button {
                    withAnimation(.smooth) {
                        if viewModel.selectAnswer() {
                            learningContainerViewModel.goToResult()
                        }
                    }
                } label: {
                    Text(viewModel.isLastQuiz ? "결과 보기" : "다음 문제")
                        .font(DSTypography.button)
                        .foregroundColor(DSColors.Text.onColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(DSColors.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(.vertical)
    }
    
    
    
    private func optionTextColor(for option: String) -> Color {
        guard viewModel.showFeedback else { return DSColors.Text.primary }
        if option == viewModel.currentQuiz.correctAnswer {
            return DSColors.Text.onColor
        }
        return viewModel.selectedOption == option ? DSColors.error : DSColors.Text.primary
    }
    
    private func optionBackground(for option: String) -> some View {
        Group {
            if viewModel.showFeedback && option == viewModel.currentQuiz.correctAnswer {
                DSColors.accent
            } else if viewModel.showFeedback && viewModel.selectedOption == option {
                DSColors.error.opacity(0.1)
            } else {
                DSColors.surface
            }
        }
    }
}
