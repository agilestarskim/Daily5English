import SwiftUI

struct StepIndicatorView: View {
    let currentStep: OnboardingStep
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(OnboardingStep.allCases, id: \.self) { step in
                Circle()
                    .fill(step.rawValue <= currentStep.rawValue ? DSColors.accent : DSColors.Text.secondary)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, DSSpacing.large)
    }
} 
