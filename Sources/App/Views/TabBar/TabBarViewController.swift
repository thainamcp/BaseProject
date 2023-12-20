import Foundation
import IQKeyboardManagerSwift
import SnapKit
import UIKit

class TabBarViewController: CardTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }
    
    func setupUI() {
        tabBar.tintColor = AppColor.titleTabbarColor
        tabBar.barTintColor = .white
        tabBar.indicatorColor = AppColor.tabbarColor
    }
    
    func setupViewController() {
        viewControllers = [homeTab, askingTab, settingTab]
    }
    
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: R.image.icon_home_dark(), selectedImage: nil)
        let homeNavTab = NavigationController(rootViewController: HomeViewController())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()
    
    lazy var askingTab: UIViewController = {
        let searchTabItem = UITabBarItem(title: "Asking", image: R.image.icon_asking_dark(), selectedImage: nil)
        let navController = NavigationController(rootViewController: AskingViewController())
        navController.tabBarItem = searchTabItem
        return navController
    }()
    
    lazy var settingTab: UIViewController = {
        let settingTabItem = UITabBarItem(title: "Settings", image: R.image.icon_setting_dark(), selectedImage: nil)
        let navController = NavigationController(rootViewController: SettingViewController())
        navController.tabBarItem = settingTabItem
        return navController
    }()
}
