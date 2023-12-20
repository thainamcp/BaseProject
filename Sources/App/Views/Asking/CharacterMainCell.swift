import Foundation
import NVActivityIndicatorView
import Kingfisher
import SnapKit
import UIKit

class CharacterMainCell: UITableViewCell {
    
    private lazy var bgView = UIView()
    public lazy var thumbnailImageView = UIImageView()
    private lazy var labelView = UIView()
    private lazy var nameLabel = UILabel()
    private lazy var inforLabel = UILabel()
    
    private let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: AppColor.blackTextColor, padding: 0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func update(_ data: CharacterModel) {
        self.loadingIndicator.startAnimating()
        let url = URL(string: data.thumbnail)
        let imgResource = ImageResource(downloadURL: url!, cacheKey: data.id)
                thumbnailImageView.kf.setImage(with: imgResource)
                {
                    result in
                    switch result {
                    case .success(let value):
                        self.loadingIndicator.stopAnimating()
                        print("value1 \(value)")
                    case .failure(let error):
                        print("value2 \(error.localizedDescription)")
                    }
                }
        nameLabel.text = data.name
        inforLabel.text = data.info
    }
    
    private func setupViews() {
        
        bgView.backgroundColor = .white
        bgView.cornerRadius = 20.scaleX
        bgView.clipsToBounds = true
        
        thumbnailImageView.cornerRadius = 40.scaleX
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.appFont(size: 18, weight: .Medium)
        nameLabel.numberOfLines = 1
        nameLabel.textColor = AppColor.blackTextColor
        
        inforLabel.font = UIFont.appFont(size: 14)
        inforLabel.numberOfLines = 0
        inforLabel.textColor = AppColor.lightGrayText
    }
    
    private func setupConstrains() {
        contentView.addSubview(bgView)
        bgView.addSubview(thumbnailImageView)
        bgView.addSubview(labelView)
        labelView.addSubview(nameLabel)
        labelView.addSubview(inforLabel)
        thumbnailImageView.addSubview(loadingIndicator)
        
        bgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15.scaleX)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(18.scaleX)
            $0.leading.equalToSuperview().inset(20.scaleX)
            $0.size.equalTo(CGSize(width: 80.scaleX, height: 80.scaleX))
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20.scaleX, height: 20.scaleX))
        }
        
        labelView.snp.makeConstraints {
            $0.centerY.equalTo(thumbnailImageView)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).inset(-10.scaleX)
            $0.trailing.equalToSuperview().inset(10.scaleX)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        inforLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom)
        }
    }
}
