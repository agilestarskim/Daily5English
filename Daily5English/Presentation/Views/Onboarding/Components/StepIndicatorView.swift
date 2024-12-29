import SwiftUI

struct StepIndicatorView: View {
    typealias Step = OnboardingViewModel.Step
    
    let currentStep: Step
    private let totalSteps = Step.allCases.count
    
    var body: some View {
        VStack(spacing: DSSpacing.small) {
            // 현재 단계 텍스트
            Text("\(currentStep.rawValue + 1)/\(totalSteps)")
                .font(.caption)
                .foregroundColor(DSColors.Text.secondary)
            
            // 게이지 바
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // 배경 게이지
                    Capsule()
                        .fill(DSColors.surface)
                        .frame(height: 4)
                    
                    // 진행 게이지
                    Capsule()
                        .fill(DSColors.accent)
                        .frame(
                            width: geometry.size.width * CGFloat(currentStep.rawValue + 1) / CGFloat(totalSteps),
                            height: 4
                        )
                }
            }
            .frame(height: 4)
            .animation(.smooth, value: currentStep)
        }
        .padding(.horizontal, DSSpacing.medium)
    }
}

#Preview {
    VStack(spacing: 20) {
        StepIndicatorView(currentStep: .guide1)
        StepIndicatorView(currentStep: .guide2)
        StepIndicatorView(currentStep: .category)
        StepIndicatorView(currentStep: .count)
        StepIndicatorView(currentStep: .level)
    }
    .padding()
} 
