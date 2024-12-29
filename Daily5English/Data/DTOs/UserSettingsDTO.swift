import Foundation

struct LearningSettingsDTO: Codable {
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
    
    func toDomain() -> LearningSettings {
        
        var difficulty: LearningSettings.Difficulty
        
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
        
        var category: LearningSettings.LearningCategory
        
        switch self.categoryPreference.lowercased() {
        case "daily":
            category = .daily
        case "business":
            category = .business
        default :
            category = .daily
        }
        
        return LearningSettings(
            userId: userId,
            difficulty: difficulty,
            dailyWordCount: dailyWordCount,
            category: category
        )
    }
    
    static func toDTO(_ settings: LearningSettings) -> LearningSettingsDTO {
        var difficulty: String
        
        switch settings.difficulty {
        case .beginner:
            difficulty = "EASY"
        case .intermediate:
            difficulty = "MEDIUM"
        case .advanced:
            difficulty = "HARD"
        }
        
        var category: String
        
        switch settings.category {
        case .daily:
            category = "DAILY"
        case .business:
            category = "BUSINESS"
        }
        
        return LearningSettingsDTO(
            userId: settings.userId,
            difficultyLevel: difficulty,
            dailyWordCount: settings.dailyWordCount,
            categoryPreference: category
        )
    }
}
