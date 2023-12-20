import Foundation
import RxSwift

class BaseViewModel: RxObject {
    
    // MARK: Public
    
    var purchaseObservable: Observable<PurchaseModel> {
        purchaseManager.purchaseObservable
            .withUnretained(self)
            .map { owner, purchase in
                owner.purchaseModel = purchase
                return purchase
            }
    }
    
    var isPurchase: Bool {
        purchaseModel.isPurchase
    }
    
    // MARK: Private
    
    private var purchaseModel: PurchaseModel = .init(isPurchase: false )
    
    private var purchaseManager: PurchaseManager {
        PurchaseManagerImpl.shared
    }
}

extension BaseViewModel {
}
