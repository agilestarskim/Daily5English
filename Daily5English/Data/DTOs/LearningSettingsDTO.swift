import Foundation

struct LearningSettingDTO: Codable {
    let userId: String
    let difficultyLevel: String
    let dailyWordCount: Int
    let categoryPreference: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case difficultyLevel = "difficulty_level"
        case dailyWordCount = "daily_word_count"
        case categoryPreference = "category_preference"
    }
    
    func toDomain() -> LearningSetting {
        
        var difficulty: Level
        
        switch self.difficultyLevel.lowercased() {
        case "easy":
            difficulty = .beginner
        case "medium":
            difficulty = .intermediate
        case "hard":
            difficulty = .advanced
        default:
            difficulty = .intermediate
        }
        
        var category: Category
        
        switch self.categoryPreference.lowercased() {
        case "daily":
            category = .daily
        case "business":
            category = .business
        default :
            category = .daily
        }
        
        return LearningSetting(
            userId: userId,
            level: difficulty,
            count: dailyWordCount,
            category: category
        )
    }
    
    static func toDTO(_ setting: LearningSetting) -> LearningSettingDTO {
        var difficulty: String
        
        switch setting.level {
        case .beginner:
            difficulty = "EASY"
        case .intermediate:
            difficulty = "MEDIUM"
        case .advanced:
            difficulty = "HARD"
        }
        
        var category: String
        
        switch setting.category {
        case .daily:
            category = "DAILY"
        case .business:
            category = "BUSINESS"
        }
        
        return LearningSettingDTO(
            userId: setting.userId,
            difficultyLevel: difficulty,
            dailyWordCount: setting.count,
            categoryPreference: category
        )
    }
}
