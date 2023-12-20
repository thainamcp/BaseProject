import Foundation
import RxSwift
import Qonversion

class IAPManager {
    static let shared = IAPManager()
    init() {}
    var listProduct = [IAPModel]()

    private var purchaseManager: PurchaseManager {
        PurchaseManagerImpl.shared
    }
    
    func configure(completion: @escaping (Bool) -> Void) {
        Qonversion.launch(withKey: Developer.qonversionKey) { result, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func disPlayProduct(completion: @escaping (Bool) -> Void) {
        Qonversion.offerings { (offerings, error) in
            guard error == nil else {
                completion(false)
                return
            }
                        
            if let products = offerings?.main?.products {
                self.listProduct.append(IAPModel(id: products.first!.qonversionID, title: "Weekly Premium", description: "3 DAYS FREE TRIAL", price: products.first!.prettyPrice))
                self.listProduct.append(IAPModel(id: products[1].qonversionID, title: "Monthly Premium", description: "", price: products[1].prettyPrice))
                self.listProduct.append(IAPModel(id: products.last!.qonversionID, title: "Lifetime Premium", description: "", price: products.last!.prettyPrice))
                completion(true)
            }
        }
    }
    
    func checkPermissions(completion: @escaping (Bool) -> Void) {
        Qonversion.checkPermissions { [weak self] permissions, error in
            
            print("---- qonversion: Permission \(permissions.count)")
            if permissions.isEmpty {
                completion(false)
            } else {
                if permissions.keys.contains("pro") {
                    UserDefaultService.shared.isPurchase = true
                    self?.purchaseManager.updatePurchase(isPurchase: true)
                } else {
                    self?.purchaseManager.updatePurchase(isPurchase: false)
                }
                completion(true)
            }
        }
    }
    
    func purchase(product: String, completion: @escaping (Bool) -> Void) {
        Qonversion.purchase(product) { result, error, cancelled in
            guard error == nil else {
                completion(false)
                print("===> error \(error?.localizedDescription)")
                return
            }
            if cancelled {
                completion(false)
                print("===> cancelled")
            }
            else {
                UserDefaultService.shared.isPurchase = true
                self.purchaseManager.updatePurchase(isPurchase: true)
                completion(true)
                print("===> purchased")
            }
        }
    }
    
    func restorePurchase(completion: @escaping (Bool) -> Void) {
        Qonversion.restore { [weak self] results, error in
            guard error == nil else {
                completion(false)
                print("---- restore \(error?.localizedDescription)")
                return
            }
            if results.isEmpty {
                completion(false)
            }
            else {
                print("====> results \(results)")
                print("====> ")
                
                if results.keys.contains("pro") {
                    UserDefaultService.shared.isPurchase = true
                    self?.purchaseManager.updatePurchase(isPurchase: true)
                } else {
                    self?.purchaseManager.updatePurchase(isPurchase: false)
                }
                completion(true)
            }
        }
    }
}

