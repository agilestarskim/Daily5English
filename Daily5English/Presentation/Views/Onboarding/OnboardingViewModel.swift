import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep = OnboardingStep.guide1
    
    func moveToNextStep() {
        if let next = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = next
        }
    }
    
    func moveToPreviousStep() {
        if let previous = OnboardingStep(rawValue: currentStep.rawValue - 1) {
            currentStep = previous
        }
    }
} 
