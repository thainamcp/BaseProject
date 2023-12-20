import Foundation
import UIKit
import SnapKit
import NVActivityIndicatorView

class LoadingIndicator : UIView {
    public static let shared = LoadingIndicator()
    
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 60, height: 50),
            type: .squareSpin, color: .red, padding: 50)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func show(indicator forView: UIView) {
        indicator.startAnimating()
        
        forView.addSubview(indicator)
        forView.backgroundColor = .orange
        indicator.snp.makeConstraints{
            $0.edges.equalToSuperview()
            indicator.bringSubviewToFront(forView)
        }
    }
    
    func hide() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
