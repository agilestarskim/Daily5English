import SwiftUI

@Observable
final class LearningContainerViewModel {
    private(set) var currentStep: LearningStep = .ready
    var isPresented = false
    
    func close() {        
        isPresented = false
        currentStep = .ready
    }
    
    func goToLearning() {
        currentStep = .learning
    }
    
    // Navigation
    func goToQuiz() {
        currentStep = .quiz
    }
    
    func goToResult() {
        currentStep = .result
    }
} 
