import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var category: LearningSettings.LearningCategory = .daily
    @Published var difficulty: LearningSettings.Difficulty = .intermediate
    @Published var dailyWordCount: Int = 5
    
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
    
    func returnLearningSettings(userId: String?) -> LearningSettings? {
        guard let userId else { return nil }
        
        return LearningSettings(
            userId: userId,
            difficulty: difficulty,
            dailyWordCount: dailyWordCount,
            category: category
        )
    }
}
