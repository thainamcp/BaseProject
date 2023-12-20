import Foundation
import RxSwift
import RxCocoa
import UIKit
import SnapKit
import ProgressHUD
import GoogleMobileAds

protocol BasePresenter: AnyObject {
    func onViewDidLoad()
}

class BaseViewController: UIViewController, GADBannerViewDelegate {
    deinit {
        print("========= Deinit", String(describing: self))
    }
    // Banner Ad
    var bannerView: GADBannerView!
    
    // Ad rewardedAd
    private var rewardedAd: GADRewardedAd?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.mainBackgroundAppColor
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
    }
    
    @objc dynamic func setupViews() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = AdMob.bannerAdId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    // Banner ad
    func addBanner() {
        view.addSubview(bannerView)
        bannerView.backgroundColor = .white
        
        bannerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func removeBanner() {
        bannerView.removeFromSuperview()
    }
    
    // Rewarded ad
//    func loadRewardedAd() {
//        let request = GADRequest()
//        GADRewardedAd.load(withAdUnitID: AdRewarded().rewardedAdId,
//                           request: request,
//                           completionHandler: { [self] ad, error in
//          if let error = error {
//            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
//            return
//          }
//          rewardedAd = ad
//          print("Rewarded ad loaded.")
//        })
//
//        rewardedAd?.fullScreenContentDelegate = self
//    }
    
//    func show() {
//      if let ad = rewardedAd {
//        ad.present(fromRootViewController: self) {
//          let reward = ad.adReward
//          print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
//          
//        }
//      } else {
//        print("Ad wasn't ready")
//      }
//    }
    
    @objc dynamic func setupRx() {
    }
    
    @objc dynamic func localize() {
    }
    
    func showHUD(_ text: String = "", lockScreen: Bool = true) {
        if lockScreen {
            view.isUserInteractionEnabled = false
        }
        ProgressHUD.fontStatus = .appFont(size: 20)
        ProgressHUD.colorBackground = .init(white: 0, alpha: 0.7)
        ProgressHUD.colorHUD = .white
        ProgressHUD.colorStatus = .customBlack
        ProgressHUD.colorAnimation = .customBlack
        ProgressHUD.animationType = .horizontalCirclesPulse
        ProgressHUD.show(text)
    }
    
    func dismissHUD() {
        view.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
    
    func showError(_ text: String = "") {
        view.isUserInteractionEnabled = true
        ProgressHUD.showError(text, image: nil, interaction: false)
    }
}
