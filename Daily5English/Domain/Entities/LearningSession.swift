import Foundation

struct LearningSession: Identifiable {
    let id: String
    let userId: String
    let date: Date
    let words: [Word]
    var isCompleted: Bool
    var lastStudiedWordIndex: Int
    
    // 진행률 계산을 위한 computed property
    var progress: Float {
        guard !words.isEmpty else { return 0 }
        return Float(lastStudiedWordIndex) / Float(words.count)
    }
} 
