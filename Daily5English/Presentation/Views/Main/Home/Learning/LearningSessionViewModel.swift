import SwiftUI

@Observable
final class LearningSessionViewModel {
    private(set) var words: [Word] = []
    var wordIndex = 0
    
    func setWords(_ words: [Word]) {
        self.words = words
        wordIndex = 0
    }
    
    // MARK: - Computed Properties
    var currentWord: Word {
        words[wordIndex]
    }
    
    var totalWordCount: Int {
        words.count
    }
    
    var currentWordNumber: Int {
        wordIndex + 1
    }
    
    var isFirstWord: Bool {
        wordIndex == 0
    }
    
    var isLastWord: Bool {
        wordIndex == words.count - 1
    }
    
    var learningProgress: Double {
        Double(currentWordNumber) / Double(totalWordCount)
    }
    
    // MARK: - Methods
    func moveToNextWord() -> Bool {
        guard !isLastWord else { return true }
        wordIndex += 1
        return false
    }
    
    func moveToPreviousWord() {
        guard !isFirstWord else { return }
        wordIndex -= 1
    }
    
    func reset() {
        wordIndex = 0
    }
}
