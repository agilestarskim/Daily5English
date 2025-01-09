import Foundation

struct Word: Codable, Identifiable {
    let id: Int
    let english: String
    let korean: String
    let level: Level
    let category: Category
    let example: Example
    let partOfSpeech: PartOfSpeech
    
    struct Example: Codable {
        let english: String
        let korean: String
    }
    
    enum PartOfSpeech: String, Codable {
        case noun = "NOUN"
        case verb = "VERB"
        case adjective = "ADJECTIVE"
        case adverb = "ADVERB"
        case preposition = "PREPOSITION"
        case conjunction = "CONJUNCTION"
        case pronoun = "PRONOUN"
        case interjection = "INTERJECTION"
    }
}
