import Foundation
import UIKit

struct ResponseMessageModel: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: UsageModel
    let choices: [ChoicesModel]
}

struct UsageModel: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct ChoicesModel: Codable {
    let message: Message
    let finish_reason: String
    let index: Int
}

struct Message: Codable {
    let role: String
    let content: String
}
