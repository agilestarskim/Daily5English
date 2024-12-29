import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    enum Step: Int, CaseIterable {
        case guide1 = 0
        case guide2 = 1
        case category = 2
        case count = 3
        case level = 4
    }
    
    @Published var category: Category = .daily
    @Published var level: Level = .intermediate
    @Published var count: Int = 5
    
    @Published var currentStep = Step.guide1
    
    func moveToNextStep() {
        if let next = Step(rawValue: currentStep.rawValue + 1) {
            currentStep = next
        }
    }
    
    func moveToPreviousStep() {
        if let previous = Step(rawValue: currentStep.rawValue - 1) {
            currentStep = previous
        }
    }
    
    func returnLearningSetting(userId: String?) -> LearningSetting? {
        guard let userId else { return nil }
        
        return LearningSetting(
            userId: userId,
            level: level,
            count: count,
            category: category
        )
    }
}
