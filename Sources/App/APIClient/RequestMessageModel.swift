import Foundation
import UIKit

struct RequestMessageModel: Encodable {
    let model: String
    let messages: [MessageModel]
    let max_tokens : Int
}

struct MessageModel: Codable {
    let role: String
    let content: String
}
