import Foundation

class WordQuizViewModel: ObservableObject {
    @Published private(set) var currentQuestionIndex = 0
    @Published private(set) var currentQuestion = "Apple"
    @Published private(set) var currentOptions = ["사과", "바나나", "오렌지", "포도"]
    @Published private(set) var selectedAnswer: String?
    @Published private(set) var showNextButton = false
    
    let totalQuestions = 10
    
    func selectAnswer(_ answer: String) {
        selectedAnswer = answer
        showNextButton = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex < totalQuestions - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showNextButton = false
            // 다음 문제 로드 로직 추가 예정
        }
    }
} 