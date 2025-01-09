import Foundation

class WordBookViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedTab = WordBookTab.history
} 
