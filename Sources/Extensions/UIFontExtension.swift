import UIKit

enum AppFontWeight: String {
    case Light
    case Regular
    case Medium
    case SemiBold
    case Bold
}

struct FontName {
    static let mainFont = "Roboto"
}

extension UIFont {
    static func appFont(size: Int, weight: AppFontWeight = .Regular) -> UIFont {
        let font = UIFont(name: FontName.mainFont + "-\(weight.rawValue)", size: size.scaleX)
        return font ?? UIFont.systemFont(ofSize: size.scaleX)
    }
}
