import Foundation
import UIKit
import RxSwift

extension UIView {
    
    static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
           let view = T()
           view.translatesAutoresizingMaskIntoConstraints = false
           builder?(view)

           return view
       }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
