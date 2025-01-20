import Foundation

struct LearningStatisticsDTO: Codable, Hashable {
    let id: String
    let userId: String
    let totalWordsCount: Int
    let streakDays: Int
    let totalLearningDays: Int
    let lastLearningDate: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case totalWordsCount = "total_words_count"
        case streakDays = "streak_days"
        case totalLearningDays = "total_learning_days"
        case lastLearningDate = "last_learning_date"
    }
    
    func toDomain() -> LearningStatistics {
        return LearningStatistics(
            id: id,
            userId: userId,
            totalWordsCount: totalWordsCount,
            streakDays: streakDays,
            totalLearningDays: totalLearningDays,
            lastLearningDate: lastLearningDate
        )
    }
} 
