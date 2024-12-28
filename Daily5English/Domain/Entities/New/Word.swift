import Foundation

struct Word: Codable, Identifiable {
    let id: String
    let english: String
    let korean: String
    let difficulty: LearningSettings.Difficulty
    let category: LearningSettings.LearningCategory
    let examples: [Example]
    let partOfSpeech: PartOfSpeech
    
    struct Example: Codable {
        let english: String
        let korean: String
    }
    
    enum PartOfSpeech: String, Codable {
        case noun
        case verb
        case adjective
        case adverb
        case preposition
        case conjunction
        case pronoun
        case interjection
    }
}
