import Foundation

struct Word: Identifiable {
    let id: UUID
    let english: String
    let korean: String
    let example: String
    
    init(id: UUID = UUID(), english: String, korean: String, example: String) {
        self.id = id
        self.english = english
        self.korean = korean
        self.example = example
    }
} 