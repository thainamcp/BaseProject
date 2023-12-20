import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    let defaultValue: T
    let key: UserDefaultService.Key
    
    init(_ key: UserDefaultService.Key, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get { return UserDefaultService.shared.get(T.self, key: key.rawValue) ?? defaultValue }
        set { UserDefaultService.shared.set(T.self, value: newValue, key: key.rawValue) }
    }
}

final class UserDefaultService: NSObject {
    enum Key: String {
        case isFirstLaunch
        case isPurchase
        case isFreeUsage
        case listHistoryChat
        case tokenConfig
    }
   
    static let shared: UserDefaultService = .init()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    @UserDefaultWrapper(.isFirstLaunch, defaultValue: true)
    var isFirstLaunch: Bool
    
    @UserDefaultWrapper(.isPurchase, defaultValue: false)
    var isPurchase: Bool
    
    @UserDefaultWrapper(.isFreeUsage, defaultValue: 0)
    var isFreeUsage: Int
    
    @UserDefaultWrapper(.listHistoryChat, defaultValue: [])
    var listHistoryChat: [MessageModel]
    
    @UserDefaultWrapper(.tokenConfig, defaultValue: TokenConfig(historyToken: "", historyTime: 0, isFirstGet: true))
    var tokenConfig: TokenConfig
}

extension UserDefaultService {
    func get<T: Codable>(_ type: T.Type, key: String) -> T? {
        guard let str = UserDefaults.standard.string(forKey: key) else {
            return nil
        }
        guard let data = str.data(using: .utf8) else { return nil }
        return try? self.decoder.decode(T.self, from: data)
    }
    
    func set<T: Codable>(_ type: T.Type, value: T, key: String) {
        guard let data = try? encoder.encode(value) else { return }
        let str = String(data: data, encoding: .utf8)
        UserDefaults.standard.set(str, forKey: key)
    }
}
