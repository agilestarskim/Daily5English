import Foundation
import SwiftUI

class WordBookViewModel: ObservableObject {
    @Published var searchText = ""
    @AppStorage("hasSeenTip") var hasSeenTip = false // 팁 상태 관리
    
    // 검색 결과를 필터링하는 함수
    func filterWords(_ words: [LearnedWord]) -> [LearnedWord] {
        guard !searchText.isEmpty else { return words }
        
        return words.filter { learnedWord in
            let word = learnedWord.word
            return word.english.localizedCaseInsensitiveContains(searchText) ||
                   word.korean.localizedCaseInsensitiveContains(searchText) ||
                   word.example.english.localizedCaseInsensitiveContains(searchText)
        }
    }
}
