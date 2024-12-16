import Foundation

@MainActor
final class WordViewModel: ObservableObject {
    @Published private(set) var words: [Word] = []
    private let useCase: WordUseCase
    
    init(useCase: WordUseCase) {
        self.useCase = useCase
    }
    
    func fetchWords() async {
        do {
            words = try await useCase.getWords()
        } catch {
            print("Error fetching words: \(error)")
        }
    }
    
    func saveWord(_ word: Word) async {
        do {
            try await useCase.saveWord(word)
            await fetchWords()
        } catch {
            print("Error saving word: \(error)")
        }
    }
} 