import SwiftUI

struct NavigationButtonsView: View {
    let currentStep: OnboardingStep
    let onPrevious: () -> Void
    let onNext: () -> Void
    
    var body: some View {
        HStack {
            Button("이전", action: onPrevious)
                .disabled(currentStep == .guide1)
            
            Spacer()
            
            Button(currentStep == .level ? "시작하기" : "다음", action: onNext)
        }
        .padding()
    }
} 
