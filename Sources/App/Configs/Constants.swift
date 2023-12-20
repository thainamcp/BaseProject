import UIKit

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.openai.com/v1"
    }
    
    struct APIParameterKey {
        static let requestModel = RequestMessageModel.self
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
    case host = "Host"
    case userAgent = "User-Agent"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case connection = "Connection"
    case xRapidAPIKey = "X-RapidAPI-Key"
    case xRapidAPIHost = "X-RapidAPI-Host"
}

enum ContentType: String {
    case json = "application/json"
    case formdata = "multipart/form-data"
}
