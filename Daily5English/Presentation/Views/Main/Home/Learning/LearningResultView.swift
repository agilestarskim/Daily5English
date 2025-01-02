import SwiftUI

struct LearningResultView: View {
    @Environment(LearningContainerViewModel.self) private var learningContainerViewModel
    @Environment(LearningResultViewModel.self) private var viewModel
    
    let restart: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            // 결과 헤더
            resultHeader
            
            Spacer()
            
            // 점수 표시
            scoreSection
            
            // 상세 결과
            resultDetails
            
            Spacer()
            
            // 버튼 영역
            VStack(spacing: 12) {
                if viewModel.shouldShowRetry {
                    Button {
                        restart()
                    } label: {
                        Text("다시 도전하기")
                            .font(DSTypography.button)
                            .foregroundColor(DSColors.Text.onColor)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(DSColors.point)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                Button {
                    learningContainerViewModel.close()
                } label: {
                    Text(viewModel.correctRate == 100 ? "학습 완료" : "다음에 다시 하기")
                        .font(DSTypography.button)
                        .foregroundColor(DSColors.Text.onColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.correctRate == 100 ? DSColors.accent : DSColors.Text.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 32)
    }
    
    private var resultHeader: some View {
        VStack(spacing: 8) {
            Image(systemName: viewModel.resultImage)
                .font(.system(size: 60))
                .foregroundColor(viewModel.resultColor)
            
            Text(viewModel.resultTitle)
                .font(DSTypography.heading1)
                .foregroundColor(DSColors.Text.primary)
            
            Text(viewModel.resultMessage)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var scoreSection: some View {
        VStack(spacing: 8) {
            Text("정답률")
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
            
            Text("\(viewModel.correctRate)%")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(viewModel.resultColor)
        }
        .padding(24)
        .background(
            Circle()
                .fill(viewModel.resultColor.opacity(0.1))
                .frame(width: 160, height: 160)
        )
    }
    
    private var resultDetails: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                statItem(
                    title: "학습한 단어",
                    value: "\(viewModel.totalWordCount)개"
                )
                
                statItem(
                    title: "맞힌 문제",
                    value: "\(viewModel.correctCount)개"
                )
            }
            
            if viewModel.correctRate < 100 {
                Text("틀린 문제는 다음 학습에서 다시 나옵니다")
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                    .padding(.top)
            }
        }
        .padding(.top)
    }
    
    private func statItem(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(DSTypography.caption1)
                .foregroundColor(DSColors.Text.secondary)
            
            Text(value)
                .font(DSTypography.heading2)
                .foregroundColor(DSColors.Text.primary)
        }
        .frame(width: 120)
        .padding()
        .background(DSColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
} 
