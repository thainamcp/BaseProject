import Foundation
import SnapKit
import UIKit
import Kingfisher
import NVActivityIndicatorView

class OptionStyleCell: UITableViewCell {
    
    private lazy var chooseStyleButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(_ data: QuoteModel) {
        
    }
    
    private func setupViews() {
        
        
    }
    
    private func setupConstrains() {
        contentView.addSubview(chooseStyleButton)
        chooseStyleButton.snp.makeConstraints {
            
        }
    }
}
