import Foundation

final class LearningUseCase {
    
    private let repository: LearningRepository
    private let wordBookRepository: WordBookRepository
    
    init(repository: LearningRepository, wordBookRepository: WordBookRepository) {
        self.repository = repository
        self.wordBookRepository = wordBookRepository
    }
    
    func hasLearnedToday(userId: String) async throws -> Bool {
        return try await repository.hasCompletedToday(userId: userId)
    }
    
    func fetchWords(setting: LearningSetting
    ) async throws -> [Word] {
        if try await repository.hasCompletedToday(userId: setting.userId) {
            // 오늘 학습을 완료했다면 서버에서 단어 로드
            return try await repository.fetchLearnedWords(userId: setting.userId)
        } else {
            // 오늘 학습을 하지 않았다면 새로운 단어를 가져오고 서버에 저장
            let learnedWords = try await wordBookRepository.fetchLearnedWords(userId: setting.userId)
            let learnedWordIds = learnedWords.map { $0.id }
            
            // 새로운 단어를 가져오려면 이미 배운 단어를 제외하기 위해 가져와야함.
            let words = try await repository.fetchRandomWords(
                setting: setting,
                learnedWordIds: learnedWordIds
            )
            
            return words
        }
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
