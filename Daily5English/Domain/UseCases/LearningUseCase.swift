import Foundation

final class LearningUseCase {
    
    private let repository: LearningRepository
    
    init(repository: LearningRepository) {
        self.repository = repository
    }
    
    func isLearningCompleted(userId: String) async throws -> Bool {
        return false
    }
    
    func fetchWords(setting: LearningSetting) async throws -> [Word] {
        return try await repository.fetchRandomWords(setting: setting)
    }
    
    func fetchQuizzes(words: [Word]) -> [Quiz] {
        // 1. 학습한 단어들을 섞음
        let shuffledWords = words.shuffled()
        
        // 2. 각 단어에 대해 퀴즈 생성
        let quizzes = shuffledWords.map { word in
            // 퀴즈 유형 랜덤 선택
            let quizType = QuizType.allCases.randomElement() ?? .wordToMeaning
            
            // 오답 보기 생성 (현재 단어를 제외한 나머지 단어들에서 선택)
            let otherWords = words.filter { $0.id != word.id }
            let wrongAnswers = Array(otherWords.shuffled().prefix(3))
            
            // 퀴즈 생성
            return createQuiz(
                type: quizType,
                correctWord: word,
                wrongWords: wrongAnswers
            )
        }
        
        return quizzes
    }
    
    private func createQuiz(type: QuizType, correctWord: Word, wrongWords: [Word]) -> Quiz {
        let allOptions = ([correctWord] + wrongWords).shuffled()
        
        switch type {
        case .wordToMeaning:
            return Quiz(
                question: correctWord.english,
                options: allOptions.map { $0.korean },
                correctAnswer: correctWord.korean,
                type: .wordToMeaning
            )
            
        case .meaningToWord:
            return Quiz(
                question: correctWord.korean,
                options: allOptions.map { $0.english },
                correctAnswer: correctWord.english,
                type: .meaningToWord
            )
            
        case .exampleSentence:
            // 예문에서 정답 단어를 밑줄로 대체
            let example = correctWord.example.english.replacingOccurrences(
                of: correctWord.english,
                with: "_____"
            )
            
            return Quiz(
                question: example,
                options: allOptions.map { $0.english },
                correctAnswer: correctWord.english,
                type: .exampleSentence
            )
        }
    }
    
    func saveLearnedWords(userId: String, words: [Word]) async throws {
        let wordIds = words.map { $0.id }
        try await repository.saveLearnedWords(userId: userId, wordIds: wordIds)
    }
}
