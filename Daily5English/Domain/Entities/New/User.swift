import Foundation

struct User: Codable {
    let id: String
    var nickname: String
    var email: String
    var lastSignInAt: Date?
    var isPremium: Bool
}
