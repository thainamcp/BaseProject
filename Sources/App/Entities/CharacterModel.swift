import Foundation

struct CharacterModel: Codable {
    let id: String
    let name: String
    let info: String
    let prompt: String
    let firstMessages: [String]
    let thumbnail: String
}
