import Foundation
import GoogleMobileAds
import Firebase
import RxSwift
import ProgressHUD

enum RewardedAdState {
    case fail, done
}

final class RewardedAdService: NSObject {
    
    // MARK: Public
    
    static let shared: RewardedAdService = .init()
    
    // MARK: Pivate properties
    
    private var rewardedAd: GADRewardedAd?
}

extension RewardedAdService {
    func preloadAdIfNeeded() {
        guard rewardedAd == nil else { return }
        
        loadAd() { _ in }
    }
    
    func loadRewardedAd(on controller: UIViewController,
                        completion: @escaping (Bool) -> ()) {
        guard rewardedAd == nil else {
            presentAd(on: controller) {
                completion(true)
            }
            return
        }
        
        loadAd { [weak self] hasAd in
            guard let wSelf = self, hasAd else {
                completion(false)
                return
            }
            
            wSelf.presentAd(on: controller) {
                completion(true)
            }
        }
    }
}

extension RewardedAdService: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        //        statusReplay.onNext(.fail)
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        rewardedAd = nil
        //        statusReplay.onNext(.done)
    }
}

private extension RewardedAdService {
    func loadAd(completion: @escaping (Bool) -> ()) {
        guard rewardedAd == nil else { return }
        
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: AdMob.rewardedAdId,
                           request: request,
                           completionHandler: { [weak self] ad, error in
            guard let wSelf = self else { return }
            
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            wSelf.rewardedAd = ad
            wSelf.rewardedAd?.fullScreenContentDelegate = wSelf
            print("Rewarded ad loaded.")
            completion(true)
        })
    }
    
    func presentAd(on controller: UIViewController, completion: @escaping () -> Void) {
        rewardedAd?.present(fromRootViewController: controller) {
            completion()
        }
    }
}

