import Foundation
import SnapKit
import UIKit

class SettingFirstCell: UITableViewCell {
    private lazy var settingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        settingLabel.setText(text: "\nSettings", color: AppColor.blackTextColor)
        settingLabel.font = UIFont.appFont(size: 32, weight: .Bold)
        settingLabel.numberOfLines = 0
    }
    
    private func setupConstrains() {
        contentView.addSubview(settingLabel)
        
        settingLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(20.scaleX)
            $0.bottom.equalToSuperview().inset(34.scaleX)
        }
    }
}

