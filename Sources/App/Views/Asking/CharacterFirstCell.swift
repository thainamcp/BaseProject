import Foundation
import SnapKit
import UIKit

class CharacterFirstCell: BaseTableViewCell {
    
    private lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        titleLabel.setText(text: "Who do you \nwant to talk with?", color: AppColor.blackTextColor)
        titleLabel.font = UIFont.appFont(size: 32, weight: .Bold)
        titleLabel.numberOfLines = 0
    }
    
    private func setupContrains() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(20.scaleX)
            $0.bottom.equalToSuperview().inset(34.scaleX)
        }
    }
}
