import SwiftUI

@Observable
final class QuizSessionViewModel {
    private var quizzes: [Quiz] = []
    var quizIndex = 0
    var selectedOption: String?
    var showFeedback = false
    
    private(set) var selectedAnswers: [String] = []
    private(set) var correctCount = 0
    
    
    func setQuizzses(_ quizzes: [Quiz]) {
        self.quizzes = quizzes
    }
    
    // MARK: - Computed Properties
    var currentQuiz: Quiz {
        quizzes[quizIndex]
    }
    
    var totalQuizCount: Int {
        quizzes.count
    }
    
    var currentQuizNumber: Int {
        quizIndex + 1
    }
    
    var quizProgress: Double {
        Double(currentQuizNumber) / Double(totalQuizCount)
    }
    
    var isLastQuiz: Bool {
        quizIndex == quizzes.count - 1
    }
    
    var correctRate: Int {
        Int((Double(correctCount) / Double(totalQuizCount)) * 100)
    }
    
    var quizTypeText: String {
        switch currentQuiz.type {
        case .wordToMeaning:
            return "단어 의미 맞추기"
        case .meaningToWord:
            return "단어 맞추기"
        case .exampleSentence:
            return "문장 완성하기"
        }
    }
    
    // MARK: - Methods
    func selectAnswer() -> Bool {
        guard let answer = selectedOption else { return false }
        
        selectedAnswers.append(answer)
        
        if answer == currentQuiz.correctAnswer {
            correctCount += 1
        }
        
        selectedOption = nil
        showFeedback = false
        
        if isLastQuiz {
            return true
        } else {
            quizIndex += 1
            return false
        }
    }
    
    func reset(with newQuizzes: [Quiz]) {
        self.quizzes = newQuizzes
        self.quizIndex = 0
        self.selectedAnswers = []
        self.correctCount = 0
    }
}
