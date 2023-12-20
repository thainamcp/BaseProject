import Foundation
import RxCocoa
import RxSwift

class AskingViewModel: BaseViewModel {
    
    private var modelManager: ModelManager {
        ModelManagerImpl.shared
    }
    
    var charactersObservable: Observable<[CharacterModel]> {
        modelManager.characters
    }
    
    var characters: [CharacterModel] {
        modelManager.charactersValue
    }
    
    var freeUsageObservable: Observable<Int> {
        modelManager.freeUsage
    }
    
    var freeUsage: Int {
        modelManager.freeUsaheValue
    }
    
    var serverConfigObservable: Observable<ServerConfigModel> {
        modelManager.serverConfig
    }
    
    var serverConfig: ServerConfigModel {
        modelManager.serverConfigValue
    }
    
    var historyChatObservable: Observable<[MessageModel]> {
        modelManager.historyChat
    }
    
    var historyChat: [MessageModel] {
        modelManager.historyChatValue
    }
}

extension AskingViewModel {
    
    func updateHistoryChat(historyModel: [MessageModel]) {
        modelManager.updateHistoryChat(historyChat: historyModel)
    }
    
    func resetHistoryChat() {
        modelManager.resetHistoryChat()
    }
}

