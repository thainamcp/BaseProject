import Foundation
import UIKit

extension Int {
    func toTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: Date(timeIntervalSinceReferenceDate: TimeInterval(self)))
    }
}

extension Int {
    var scaleY: CGFloat {
        return self.toCGFloat.scaleY()
    }
    
    var scaleX: CGFloat {
        return self.toCGFloat.scaleX()
    }
    
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}
