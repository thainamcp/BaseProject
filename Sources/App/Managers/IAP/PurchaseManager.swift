import Foundation
import RxSwift
import RxCocoa

protocol PurchaseManager {
    var purchaseObservable: Observable<PurchaseModel> { get }
    
    func updatePurchase(isPurchase: Bool)
}

final class PurchaseManagerImpl {
    static let shared: PurchaseManagerImpl = .init()
    
    private let purchasePublisher: BehaviorRelay<PurchaseModel> = {
        .init(value: PurchaseModel(isPurchase: false))
    }()
}

extension PurchaseManagerImpl: PurchaseManager {
    
    var purchaseObservable: Observable<PurchaseModel> {
        purchasePublisher.asObservable()
    }
    
    func updatePurchase(isPurchase: Bool) {
        var isPurchase = PurchaseModel(isPurchase: isPurchase)
        // Emit event for subscribers
        purchasePublisher.accept(isPurchase)
    }
}
