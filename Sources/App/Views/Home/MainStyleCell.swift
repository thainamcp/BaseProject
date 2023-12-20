import Foundation
import SnapKit
import UIKit

class QuotesFirstCell: UITableViewCell {
    private lazy var quoteLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        quoteLabel.setText(text: "How are you \nfeeling today?", color: AppColor.blackTextColor)
        quoteLabel.font = UIFont.appFont(size: 32, weight: .Bold)
        quoteLabel.numberOfLines = 0
    }
    
    private func setupConstrains() {
        contentView.addSubview(quoteLabel)
        
        quoteLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(20.scaleX)
            $0.bottom.equalToSuperview().inset(34.scaleX)
        }
    }
}
