import Foundation

struct RequestGenImageModel: Codable {
    let prompt: String
    let n: Int
    let size: String
}
