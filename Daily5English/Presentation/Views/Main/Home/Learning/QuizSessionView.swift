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
                        viewModel.selectedOption = option
                        viewModel.showFeedback = true
                    } label: {
                        HStack {
                            Text(option)
                                .font(DSTypography.body1)
                                .foregroundColor(optionTextColor(for: option))
                            
                            Spacer()
                            
                            // 피드백 아이콘
                            if viewModel.showFeedback {
                                if option == viewModel.currentQuiz.correctAnswer {
                                    Label("정답", systemImage: "checkmark.circle.fill")
                                        .foregroundColor(DSColors.accent)
                                        .font(DSTypography.caption1)
                                } else if viewModel.selectedOption == option {
                                    Label("오답", systemImage: "xmark.circle.fill")
                                        .foregroundColor(DSColors.error)
                                        .font(DSTypography.caption1)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(optionBackground(for: option))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(optionBorderColor(for: option), lineWidth: 1.5)
                                )
                        )
                    }
                    .disabled(viewModel.showFeedback)
                }
            }
            .padding(.horizontal)
            
            // 다음 버튼 - 항상 표시
            Button {
                if viewModel.selectAnswer() {
                    learningContainerViewModel.goToResult()
                }
            } label: {
                Text(viewModel.isLastQuiz ? "결과 보기" : "다음 문제")
                    .font(DSTypography.button)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.showFeedback ? DSColors.accent : DSColors.accent.opacity(0.3))
                    .foregroundColor(viewModel.showFeedback ? DSColors.Text.onColor : DSColors.Text.onColor.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(!viewModel.showFeedback)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    private func optionBorderColor(for option: String) -> Color {
        guard viewModel.showFeedback else {
            return viewModel.selectedOption == option ? DSColors.accent : Color.clear
        }
        if option == viewModel.currentQuiz.correctAnswer {
            return DSColors.accent
        }
        return viewModel.selectedOption == option ? DSColors.error : Color.clear
    }
    
    private func optionTextColor(for option: String) -> Color {
        guard viewModel.showFeedback else { 
            return DSColors.Text.primary 
        }
        if option == viewModel.currentQuiz.correctAnswer {
            return DSColors.accent
        }
        return viewModel.selectedOption == option ? DSColors.error : DSColors.Text.primary
    }
    
    private func optionBackground(for option: String) -> Color {
        if viewModel.showFeedback {
            if option == viewModel.currentQuiz.correctAnswer {
                return DSColors.accent.opacity(0.1)
            } else if viewModel.selectedOption == option {
                return DSColors.error.opacity(0.1)
            }
        }
        return DSColors.surface
    }
}
