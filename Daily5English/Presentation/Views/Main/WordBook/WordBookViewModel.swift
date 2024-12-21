import Foundation

class WordBookViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedTab = WordBookTab.history
    @Published private(set) var words: [WordItem] = []
    @Published private(set) var bookmarkedWords: Set<UUID> = []
    
    // 더미 데이터
    init() {
        words = [
            WordItem(
                id: UUID(),
                english: "Apple",
                korean: "사과",
                example: "I eat an apple every day.",
                lastStudied: Date()
            ),
            WordItem(
                id: UUID(),
                english: "Book",
                korean: "책",
                example: "I love reading books.",
                lastStudied: Date().addingTimeInterval(-86400)
            ),
            // 더 많은 더미 데이터 추가 가능
        ]
    }
    
    var filteredWords: [WordItem] {
        let filtered = words.filter { word in
            if searchText.isEmpty { return true }
            return word.english.localizedCaseInsensitiveContains(searchText) ||
                   word.korean.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectedTab {
        case .history:
            return filtered
        case .bookmarks:
            return filtered.filter { bookmarkedWords.contains($0.id) }
        }
    }
    
    func isBookmarked(_ word: WordItem) -> Bool {
        bookmarkedWords.contains(word.id)
    }
    
    func toggleBookmark(_ word: WordItem) {
        if bookmarkedWords.contains(word.id) {
            bookmarkedWords.remove(word.id)
        } else {
            bookmarkedWords.insert(word.id)
        }
    }
} 