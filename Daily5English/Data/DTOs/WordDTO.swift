//
//  WordDTO.swift
//  Daily5English
//
//  Created by 김민성 on 1/1/25.
//

import Foundation

struct WordDTO: Codable {
    let id: Int
    let english: String
    let korean: String
    let partOfSpeech: String
    let exampleEnglish: String
    let exampleKorean: String
    let level: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case english = "english"
        case korean = "korean"
        case partOfSpeech = "part_of_speech"
        case exampleEnglish = "example_sentence"
        case exampleKorean = "example_sentence_korean"
        case level = "difficulty_level"
        case category = "category"
    }
    
    func toDomain() -> Word {
        
        var level: Level
        
        switch self.level.lowercased() {
        case "easy":
            level = .beginner
        case "medium":
            level = .intermediate
        case "hard":
            level = .advanced
        default:
            level = .intermediate
        }
        
        var category: Category
        
        switch self.category.lowercased() {
        case "daily":
            category = .daily
        case "business":
            category = .business
        default :
            category = .daily
        }
        
        return Word(
            id: id,
            english: english,
            korean: korean,
            level: level,
            category: category,
            example: Word.Example(english: exampleEnglish, korean: exampleKorean),
            partOfSpeech: Word.PartOfSpeech(rawValue: partOfSpeech) ?? .noun
        )
    }
}
