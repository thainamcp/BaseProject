import Foundation
import SnapKit
import UIKit

class SettingCell: UITableViewCell {
    
    private lazy var backgroundCellView = UIView()
    public lazy var iconShare = UIImageView()
    private lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundCellView.backgroundColor = AppColor.cellColor
        backgroundCellView.cornerRadius = 15.scaleX
        
        titleLabel.font = UIFont.appFont(size: 16, weight: .Bold)
        
        iconShare.image = R.image.icon_share()
        iconShare.isHidden = true
    }
    
    func setupConstrains() {
        contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(iconShare)
        backgroundCellView.addSubview(titleLabel)
        
        backgroundCellView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15.scaleX)
            $0.height.equalTo(50.scaleX)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20.scaleX)
            $0.centerY.equalToSuperview()
        }
        
        iconShare.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(10.scaleX)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 25.scaleX, height: 25.scaleX))
        }
    }
    
    public func update(title: String, index: Int){
        titleLabel.setText(text: title, color: AppColor.blackTextColor)
        if (index == 0) {
            iconShare.isHidden = false
        }
    }
}


