import Foundation
import UIKit
import RxCocoa
import RxSwift
import Firebase

protocol ModelManager {
    var freeUsage: Observable<Int> { get }
    var freeUsaheValue: Int { get }
    
    var characters: Observable<[CharacterModel]> { get }
    var charactersValue: [CharacterModel] { get }
    
    var quotes: Observable<[QuoteModel]> { get }
    var quotesValue: [QuoteModel] { get }
    
    var serverConfig: Observable<ServerConfigModel> { get }
    var serverConfigValue: ServerConfigModel { get }
    
    var historyChat: Observable<[MessageModel]> { get }
    var historyChatValue: [MessageModel] { get }
      
    func updateHistoryChat(historyChat: [MessageModel])
    func resetHistoryChat()
}

final class ModelManagerImpl {
    static let shared: ModelManagerImpl = .init()
    let remoteConfig = RemoteConfig.remoteConfig()
    
    private let characterPublisher: BehaviorRelay<[CharacterModel]> = {
        .init(value: [])
    }()
    
    private let quotesPublisher: BehaviorRelay<[QuoteModel]> = {
        .init(value: [])
    }()
    
    private let serverConfigPublisher: BehaviorRelay<ServerConfigModel> = {
        .init(value: ServerConfigModel(model: "", limit_text: 0, max_tokens: 0, follow_up: 0))
    }()
    
    private let freeUsagePublisher: BehaviorRelay<Int> = {
        .init(value: 0)
    }()
    
    private let historyChatPublisher: BehaviorRelay<[MessageModel]> = {
        .init(value: [])
    }()
    
    init() {
        loadHistoryChat()
        loadData()
    }
    
    func loadHistoryChat() {
        let listHistoryChat = UserDefaultService.shared.listHistoryChat
        historyChatPublisher.accept(listHistoryChat)
    }
    
    func loadData() {
        remoteConfig.fetch(withExpirationDuration: 30 * 60) { [unowned self] (status, error) in
            guard error == nil else { return }
            remoteConfig.activate()
            do {
                let dataFreeUsage = remoteConfig.configValue(forKey: "free_usage").numberValue
                freeUsagePublisher.accept(Int(truncating: dataFreeUsage))
                
                let dataCharacter = remoteConfig.configValue(forKey: "character_config").dataValue
                let decodeDataCharacter = try JSONDecoder().decode([CharacterModel].self, from: dataCharacter)
                characterPublisher.accept(decodeDataCharacter)
                
                let dataQuote = remoteConfig.configValue(forKey: "quote_config").dataValue
                let decodeDataQuote = try JSONDecoder().decode([QuoteModel].self, from: dataQuote)
                quotesPublisher.accept(decodeDataQuote)
                
                let dataServerConfig = remoteConfig.configValue(forKey: "server_config").dataValue
                let decodeDataServerConfig = try JSONDecoder().decode(ServerConfigModel.self, from: dataServerConfig)
                serverConfigPublisher.accept(decodeDataServerConfig)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension ModelManagerImpl: ModelManager {
    var freeUsage: Observable<Int> {
        freeUsagePublisher.asObservable()
    }
    
    var freeUsaheValue: Int {
        freeUsagePublisher.value
    }
    
    var characters: Observable<[CharacterModel]> {
        characterPublisher.asObservable()
    }
    
    var charactersValue: [CharacterModel] {
        characterPublisher.value
    }
    
    var quotes: Observable<[QuoteModel]> {
        quotesPublisher.asObservable()
    }
    
    var quotesValue: [QuoteModel] {
        quotesPublisher.value
    }
    
    var serverConfig: Observable<ServerConfigModel> {
        serverConfigPublisher.asObservable()
    }
    
    var serverConfigValue: ServerConfigModel {
        serverConfigPublisher.value
    }
    
    var historyChat: Observable<[MessageModel]> {
        historyChatPublisher.asObservable()
    }
    
    var historyChatValue: [MessageModel] {
        historyChatPublisher.value
    }
    
    func updateHistoryChat(historyChat: [MessageModel]) {
        let followUp = serverConfigValue.follow_up
        var historyChatUserDefault = UserDefaultService.shared.listHistoryChat
        
        if (historyChatUserDefault.count == (followUp * 2)) {
            historyChatUserDefault.append(historyChat[0])
            historyChatUserDefault.append(historyChat[1])
            historyChatUserDefault.remove(at: 1)
            historyChatUserDefault.remove(at: 0)
            UserDefaultService.shared.listHistoryChat = historyChatUserDefault
            historyChatPublisher.accept(historyChatUserDefault)
        } else {
            historyChatUserDefault.append(historyChat[0])
            historyChatUserDefault.append(historyChat[1])
            UserDefaultService.shared.listHistoryChat = historyChatUserDefault
            historyChatPublisher.accept(historyChatUserDefault)
        }
    }
    
    func resetHistoryChat() {
        UserDefaultService.shared.listHistoryChat = []
        historyChatPublisher.accept([])
    }
}
