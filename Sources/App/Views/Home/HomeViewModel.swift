import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private var modelManager: ModelManager {
        ModelManagerImpl.shared
    }
    
    var quotesObservable: Observable<[QuoteModel]> {
        modelManager.quotes
    }
    
    var quotes: [QuoteModel] {
        modelManager.quotesValue
    }
}

extension HomeViewModel {
    
}
