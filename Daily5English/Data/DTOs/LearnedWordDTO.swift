import Foundation

struct LearnedWordDTO: Codable {
    let wordId: Int
    let reviewedCount: Int
    let learnedAt: String
    let lastReviewedAt: String?
    let word: WordDTO
    
    enum CodingKeys: String, CodingKey {
        case wordId = "word_id"
        case reviewedCount = "reviewed_count"
        case learnedAt = "learned_at"
        case lastReviewedAt = "last_reviewed_at"
        case word = "words"
    }
    
    func toDomain() -> LearnedWord {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let learned = dateFormatter.date(from: learnedAt)
        let lastReviewed = lastReviewedAt.flatMap { dateFormatter.date(from: $0) }
        
        return LearnedWord(
            wordId: wordId,
            word: word.toDomain(),
            learnedAt: learned ?? Date(),
            lastReviewedAt: lastReviewed,
            reviewedCount: reviewedCount
        )
    }
}
