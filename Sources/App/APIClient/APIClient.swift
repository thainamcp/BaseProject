import Foundation
import SwiftJWT
import Alamofire

class APIClient {
    
    static func token() -> String {
        var token   = ""
        let currentTime     = Int(Int64((Date().timeIntervalSince1970).rounded()))
        let tokenConfig     = UserDefaultService.shared.tokenConfig
        let myHeader    = Header()
        let myClaims    = MyClaims(token: "admin", exp: Date(timeIntervalSinceNow: 15 * 60))
        var myJWT       = JWT(header: myHeader, claims: myClaims)
        let secret      = "tiny-chatgpt"
        let jwtSigner   = JWTSigner.hs256(key: Data(secret.utf8))
        
        if(tokenConfig.isFirstGet == true) {
            token = try! myJWT.sign(using: jwtSigner)
            UserDefaultService.shared.tokenConfig = TokenConfig(historyToken: token, historyTime: currentTime, isFirstGet: false)
        } else if ((currentTime - tokenConfig.historyTime) >= 900) {
            token = try! myJWT.sign(using: jwtSigner)
            UserDefaultService.shared.tokenConfig = TokenConfig(historyToken: token, historyTime: currentTime, isFirstGet: false)
        } else {
            token = tokenConfig.historyToken
        }
        
        print("Bearer \(token)")
        
        return "Bearer \(token)"
    }
    
    static func requestQuestion(question: String, prompt: String, completion: @escaping (Result<ResponseMessageModel>) -> Void) {
        let viewModel: AskingViewModel = .init()
        let model           = viewModel.serverConfig.model
        let maxTokens       = viewModel.serverConfig.max_tokens
        var historyChat     = viewModel.historyChat
    
        historyChat.append(MessageModel(role: "user", content: question))
        historyChat.insert(MessageModel(role: "system", content: prompt), at: 0)
        
        print("chat model \(historyChat)")
        let requestModel = RequestMessageModel(model: model, messages: historyChat, max_tokens: maxTokens)
        
        var request = URLRequest(url: URL(string: Developer.domain + Developer.endpointChat)!)
        do {
            request.httpBody = try JSONEncoder().encode(requestModel)
        } catch {}
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(token(), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        AF.request(request).responseDecodable { (respone: DataResponse<ResponseMessageModel>) in
            completion(respone.result)
            
            print("data response \(respone)")
        }
    }
    
    static func requestGenImage(requestModel: RequestGenImageModel, completion: @escaping (Result<ResponseGenImageModel>) -> Void) {
        var request = URLRequest(url: URL(string: Developer.domain + Developer.endpointGenImage)!)
        do {
            request.httpBody = try JSONEncoder().encode(requestModel)
        } catch {}
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(token(), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        AF.request(request).responseDecodable { (response: DataResponse<ResponseGenImageModel>) in
            completion(response.result)
        }
    }
}
