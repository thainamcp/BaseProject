import Foundation
import UIKit
import SnapKit
import Qonversion
import NVActivityIndicatorView
import Hero

class DirectStoreViewController: BaseViewController {
    
    private lazy var feelImageView = UIImageView()
    private lazy var bgGiftView = UIView()
    private lazy var giftLabel = UILabel()
    
    private lazy var vListInfor = UIView()
    private lazy var iconUser = UIImageView()
    private lazy var titleUser = UILabel()
    private lazy var iconHeart = UIImageView()
    private lazy var titleHeart = UILabel()
    private lazy var iconLotus = UIImageView()
    private lazy var titleLotus = UILabel()
    private lazy var iconMonk = UIImageView()
    private lazy var titleMonk = UILabel()
    
    private lazy var weeklyButton = UIButton()
    private lazy var weeklyTitleLabel = UILabel()
    private lazy var weeklyPriceLabel = UILabel()
    
    private lazy var monthlyButton = UIButton()
    private lazy var monthlyTitleLabel = UILabel()
    private lazy var monthlyPriceLabel = UILabel()
    
    private lazy var lifetimeButton = UIButton()
    private lazy var lifetimeTitleLabel = UILabel()
    private lazy var lifetimePriceLabel = UILabel()
    
    private lazy var noThanksButton = UIButton()
    private lazy var privacyButton = UIButton()
    private lazy var restoreButton = UIButton()
    private lazy var termButton = UIButton()
    
    private lazy var lineView = UIView()
    
    private let loading = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: AppColor.blackTextColor, padding: 0)
    
    private let viewModel: DirecStoreViewModel = .init()
    
    private var purchaseManager: PurchaseManager {
        PurchaseManagerImpl.shared
    }
    
    let userDefault = UserDefaultService.shared
    let iapManager = IAPManager.shared
}

extension DirectStoreViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        displayProducts()
    }
    
    override func setupViews() {
        super.setupViews()
        
        //MARK: SETUP VIEWS
        feelImageView.image = R.image.feel_first_quote()
        feelImageView.contentMode = .scaleAspectFit

        bgGiftView.backgroundColor = AppColor.tabbarColor
        bgGiftView.cornerRadius = 15.scaleX
        bgGiftView.clipsToBounds = true
        
        giftLabel.setText(text: "A GIFT TO YOURSELF", color: AppColor.blackTextColor)
        giftLabel.font = UIFont.appFont(size: 12, weight: .Bold)
        
        iconUser.image = R.image.icon_ds_user()
        titleUser.setText(text: "Know yourself better than ever", color: AppColor.blackTextColor)
        titleUser.font = UIFont.appFont(size: 14, weight: .Medium)
        
        iconHeart.image = R.image.icon_ds_heart()
        titleHeart.setText(text: "Reduce stress and anxiety", color: AppColor.blackTextColor)
        titleHeart.font = UIFont.appFont(size: 14, weight: .Medium)
        
        iconLotus.image = R.image.icon_ds_lotus()
        titleLotus.setText(text: "Experience the power of mindfulness", color: AppColor.blackTextColor)
        titleLotus.font = UIFont.appFont(size: 14, weight: .Medium)
        
        iconMonk.image = R.image.icon_ds_monk()
        titleMonk.setText(text: "Get motivated with inspirational characters", color: AppColor.blackTextColor)
        titleMonk.font = UIFont.appFont(size: 14, weight: .Medium)
        
        weeklyButton.cornerRadius = 20.scaleX
        weeklyButton.layer.masksToBounds = true
        weeklyButton.backgroundColor = AppColor.tabbarColor
        
        weeklyTitleLabel.font = UIFont.appFont(size: 18, weight: .Bold)
        weeklyPriceLabel.font = UIFont.appFont(size: 21, weight: .Bold)
        
        monthlyButton.cornerRadius = 20.scaleX
        monthlyButton.layer.masksToBounds = true
        monthlyButton.backgroundColor = .clear
        monthlyButton.layer.borderWidth = 1.scaleX
        monthlyButton.layer.borderColor = AppColor.blackTextColor.cgColor

        monthlyTitleLabel.font = UIFont.appFont(size: 18, weight: .Bold)
        monthlyPriceLabel.font = UIFont.appFont(size: 21, weight: .Bold)
        
        lifetimeButton.cornerRadius = 20.scaleX
        lifetimeButton.layer.masksToBounds = true
        lifetimeButton.backgroundColor = .clear
        lifetimeButton.layer.borderWidth = 1.scaleX
        lifetimeButton.layer.borderColor = AppColor.blackTextColor.cgColor
        
        lifetimeTitleLabel.font = UIFont.appFont(size: 18, weight: .Bold)
        lifetimePriceLabel.font = UIFont.appFont(size: 21, weight: .Bold)
        
        let noThanks = NSMutableAttributedString(string: "No thanks", attributes: [NSAttributedString.Key.font: UIFont.appFont(size: 15),NSAttributedString.Key.foregroundColor: AppColor.nothanksColor, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        noThanksButton.setAttributedTitle(noThanks, for: .normal)
        
        let restore = NSMutableAttributedString(string: "Restore Purchase", attributes: [NSAttributedString.Key.font: UIFont.appFont(size: 14),NSAttributedString.Key.foregroundColor: AppColor.blackTextColor])
        restoreButton.setAttributedTitle(restore, for: .normal)
        
        let privacy = NSMutableAttributedString(string: "Privacy Policy", attributes: [NSAttributedString.Key.font: UIFont.appFont(size: 14),NSAttributedString.Key.foregroundColor: AppColor.termpriColor])
        privacyButton.setAttributedTitle(privacy, for: .normal)
        
        lineView.backgroundColor = AppColor.termpriColor
        
        let term = NSMutableAttributedString(string: "Terms Of Use", attributes: [NSAttributedString.Key.font: UIFont.appFont(size: 14),NSAttributedString.Key.foregroundColor: AppColor.termpriColor])
        termButton.setAttributedTitle(term, for: .normal)
        
        //MARK: SETUP CONSTRAINS
        view.addSubview(feelImageView)
        view.addSubview(bgGiftView)
        bgGiftView.addSubview(giftLabel)

        view.addSubview(vListInfor)
        vListInfor.addSubview(iconUser)
        vListInfor.addSubview(titleUser)
        vListInfor.addSubview(iconHeart)
        vListInfor.addSubview(titleHeart)
        vListInfor.addSubview(iconLotus)
        vListInfor.addSubview(titleLotus)
        vListInfor.addSubview(iconMonk)
        vListInfor.addSubview(titleMonk)

        view.addSubview(lineView)
        view.addSubview(privacyButton)
        view.addSubview(termButton)
        view.addSubview(restoreButton)
        view.addSubview(noThanksButton)
        
        view.addSubview(weeklyButton)
        weeklyButton.addSubview(weeklyTitleLabel)
        weeklyButton.addSubview(weeklyPriceLabel)
        
        view.addSubview(monthlyButton)
        monthlyButton.addSubview(monthlyTitleLabel)
        monthlyButton.addSubview(monthlyPriceLabel)
        
        view.addSubview(lifetimeButton)
        lifetimeButton.addSubview(lifetimeTitleLabel)
        lifetimeButton.addSubview(lifetimePriceLabel)

        view.addSubview(loading)
        
        feelImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.scaleX)
            $0.top.equalToSuperview().inset(Developer.isHasNortch ? 70.scaleX : 30.scaleX)
            $0.height.equalTo(feelImageView.snp.width).multipliedBy(0.538)
        }
        
        bgGiftView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(feelImageView.snp.bottom).inset(-10.scaleX)
        }
        
        giftLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6.scaleX)
            $0.leading.trailing.equalToSuperview().inset(16.scaleX)
        }
        
        // view list infor
        vListInfor.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bgGiftView.snp.bottom).inset(Developer.isHasNortch ? -35.scaleX : -15.scaleX)
        }
        
        iconUser.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20.scaleX, height: 20.scaleX))
        }
        
        titleUser.snp.makeConstraints {
            $0.leading.equalTo(iconUser.snp.trailing).inset(-10.scaleX)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleUser.snp.centerY)
        }
        
        iconHeart.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(iconUser.snp.bottom).inset(-10.scaleX)
            $0.size.equalTo(CGSize(width: 20.scaleX, height: 20.scaleX))
        }
        
        titleHeart.snp.makeConstraints {
            $0.leading.equalTo(iconHeart.snp.trailing).inset(-10.scaleX)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(iconHeart.snp.centerY)
        }
        
        iconLotus.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(iconHeart.snp.bottom).inset(-10.scaleX)
            $0.size.equalTo(CGSize(width: 20.scaleX, height: 20.scaleX))
        }
        
        titleLotus.snp.makeConstraints {
            $0.leading.equalTo(iconLotus.snp.trailing).inset(-10.scaleX)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(iconLotus.snp.centerY)
        }
        
        iconMonk.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(iconLotus.snp.bottom).inset(-10.scaleX)
            $0.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20.scaleX, height: 20.scaleX))
        }
        
        titleMonk.snp.makeConstraints {
            $0.leading.equalTo(iconMonk.snp.trailing).inset(-10.scaleX)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(iconMonk.snp.centerY)
        }

        lineView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Developer.isHasNortch ? 22.scaleX : 12.scaleX)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1.scaleX)
            $0.height.equalTo(17.scaleX)
        }

        privacyButton.snp.makeConstraints {
            $0.leading.equalTo(lineView.snp.trailing).inset(-5.scaleX)
            $0.centerY.equalTo(lineView.snp.centerY)
        }

        termButton.snp.makeConstraints {
            $0.trailing.equalTo(lineView.snp.leading).inset(-5.scaleX)
            $0.centerY.equalTo(lineView.snp.centerY)
        }

        restoreButton.snp.makeConstraints {
            $0.bottom.equalTo(lineView.snp.top)
            $0.centerX.equalToSuperview()
        }

        noThanksButton.snp.makeConstraints {
            $0.bottom.equalTo(restoreButton.snp.top).inset(Developer.isHasNortch ? -30.scaleX : -15.scaleX)
            $0.centerX.equalToSuperview()
        }

        // button life time
        lifetimeButton.snp.makeConstraints {
            $0.bottom.equalTo(noThanksButton.snp.top).inset(Developer.isHasNortch ? -30.scaleX : -20.scaleX)
            $0.leading.trailing.equalToSuperview().inset(40.scaleX)
            $0.height.equalTo(lifetimeButton.snp.width).multipliedBy(0.191)
        }

        lifetimeTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15.scaleX)
        }

        lifetimePriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.scaleX)
        }

        // button monthly
        monthlyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40.scaleX)
            $0.bottom.equalTo(lifetimeButton.snp.top).inset(-10.scaleX)
            $0.height.equalTo(monthlyButton.snp.width).multipliedBy(0.191)
        }

        monthlyTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15.scaleX)
        }

        monthlyPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.scaleX)
        }

        // button weekly
        weeklyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40.scaleX)
            $0.bottom.equalTo(monthlyButton.snp.top).inset(-10.scaleX)
            $0.height.equalTo(weeklyButton.snp.width).multipliedBy(0.191)
        }

        weeklyTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15.scaleX)
        }

        weeklyPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.scaleX)
        }

        loading.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 50.scaleX, height: 50.scaleX))
            $0.center.equalToSuperview()
        }
    }
    
    private func displayProducts() {
        self.loading.startAnimating()
        iapManager.disPlayProduct { success in
            if success {
                self.loading.stopAnimating()
                
                let weekly = self.iapManager.listProduct.first
                let monthly = self.iapManager.listProduct[1]
                let lifetime = self.iapManager.listProduct.last
                
                self.weeklyPriceLabel.setText(text: weekly!.price, color: AppColor.blackTextColor)
                self.monthlyPriceLabel.setText(text: monthly.price, color: AppColor.blackTextColor)
                self.lifetimePriceLabel.setText(text: lifetime!.price, color: AppColor.blackTextColor)
                
                self.weeklyTitleLabel.setText(text: weekly!.title, color: AppColor.blackTextColor)
                self.lifetimeTitleLabel.setText(text: lifetime!.title, color: AppColor.blackTextColor)
                self.monthlyTitleLabel.setText(text: monthly.title, color: AppColor.blackTextColor)
                
            } else {
                if self.userDefault.isFirstLaunch {
                    self.closeDiecStore()
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    func closeDiecStore() {
        self.userDefault.isFirstLaunch = false
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
        
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
    }
    
    private func purchaseSuccess() {
        if userDefault.isFirstLaunch {
            print("========> purchase success")
            loading.stopAnimating()
            userDefault.isFirstLaunch = false
            closeDiecStore()
        } else {
            print("========> purchase success")
            loading.stopAnimating()
            dismiss(animated: true)
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        noThanksButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                // set is first launch
                if owner.userDefault.isFirstLaunch {
                    owner.closeDiecStore()
                } else {
                    owner.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        lifetimeButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.loading.startAnimating()
                owner.iapManager.purchase(product: Developer.lifetimeProduct) { success in
                    if success {
                        owner.purchaseManager.updatePurchase(isPurchase: true)
                        owner.purchaseSuccess()
                    }
                    else {
                        print("========> failed lifetime to buy")
                        owner.loading.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        monthlyButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                
                owner.loading.startAnimating()
                owner.iapManager.purchase(product: Developer.monthlyProduct) { success in
                    if success {
                        owner.purchaseManager.updatePurchase(isPurchase: true)
                        owner.purchaseSuccess()
                    }
                    else {
                        print("========> failed lifetime to buy")
                        owner.loading.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        weeklyButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.loading.startAnimating()
                owner.iapManager.purchase(product: Developer.weeklyProduct) { success in
                    if success {
                        owner.purchaseManager.updatePurchase(isPurchase: true)
                        owner.purchaseSuccess()
                    }
                    else {
                        print("========> failed lifetime to buy")
                        owner.loading.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        restoreButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.loading.startAnimating()
                owner.iapManager.restorePurchase { success in
                    if success {
                        owner.purchaseSuccess()
                        print("=======> restore ok")
                    }
                    else {
                        print("=======> restore failed")
                        owner.loading.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        privacyButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let url = URL(string: Developer.privacyPolicy)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
            .disposed(by: disposeBag)
        
        termButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let url = URL(string: Developer.termOfUse)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
            .disposed(by: disposeBag)
    }
}
