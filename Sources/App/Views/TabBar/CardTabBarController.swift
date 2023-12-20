import UIKit

open class CardTabBarController: UITabBarController {
    // MARK: - Views
    private lazy var cardTabBar = CardTabBarView()

    // MARK: - Properties
    open override var selectedIndex: Int {
        didSet {
            cardTabBar.select(at: selectedIndex)
        }
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(cardTabBar, forKey: "tabBar")
    }
    
    func setTabBar(hidden: Bool, animated: Bool) {
            let animationDuration = 0
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
                var frame = self.tabBar.frame
                frame.origin.y = self.view.frame.height
                if !hidden {
                    frame.origin.y -= frame.height
                } else {
                    let backgroundImageSize = self.tabBar.backgroundImage?.size ?? CGSize.zero
                    let heightDiff: CGFloat = backgroundImageSize.height - frame.height
                    // If background image size is large, tabBar top seem.
                    if heightDiff > 0 {
                        frame.origin.y += heightDiff
                    }
                }
                self.tabBar.frame = frame
            }, completion:nil)
        }
}

extension CardTabBarController {
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              let controller = viewControllers?[index] else { return }
        
        selectedIndex = index
        delegate?.tabBarController?(self, didSelect: controller)
    }
}
