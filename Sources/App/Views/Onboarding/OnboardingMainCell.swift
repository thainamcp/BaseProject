import Foundation
import RxSwift
import UIKit
import SnapKit

class OnboardingMainCell: UICollectionViewCell {
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    public lazy var nextButton = UIButton()
    
    var nextAction: (() -> Void)?
    
    var disposeBag: DisposeBag = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = AppColor.whiteTextColor
        titleLabel.font = UIFont.appFont(size: 24, weight: .SemiBold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
    }
    
    func setupConstrains() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nextButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50.scaleX)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(58.scaleX)
            $0.bottom.equalTo(nextButton.snp.top).inset(-15.scaleX)
        }
    }
    
    func setupRx() {
        nextButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.nextAction?()
            })
            .disposed(by: disposeBag)
    }
    
    public func update(background: String, title: String, button: String, index: Int) {
        backgroundImageView.image = UIImage(named: background)
        titleLabel.text = title
        nextButton.setImage(UIImage(named: button), for: .normal)
        nextButton.imageView?.contentMode = .scaleAspectFill
        
        switch index {
        case 0:
            titleLabel.textColor = AppColor.whiteTextColor
        case 1:
            titleLabel.textColor = AppColor.blackTextColor
        case 2:
            titleLabel.textColor = AppColor.blackTextColor
        default:
            titleLabel.textColor = AppColor.blackTextColor
        }
    }
}

