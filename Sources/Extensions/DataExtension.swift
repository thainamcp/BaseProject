
import Foundation
import CryptoKit
import SwiftJWT
import FileProvider

extension Data {
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

struct MyClaims: Claims {
    let token: String
    let exp: Date
}

