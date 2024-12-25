import Foundation

struct UserSettingsDTO: Codable {
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
    
    func toDomain() -> UserSettings {
        return UserSettings(
            userId: userId,
            difficultyLevel: LearningLevel(string: self.difficultyLevel.lowercased()),
            dailyWordCount: dailyWordCount,
            categoryPreference: LearningCategory(string: categoryPreference.lowercased())
        )
    }
} 
