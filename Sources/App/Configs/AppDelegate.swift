import Foundation
import UIKit
import Firebase
import Qonversion
import GoogleMobileAds
import IQKeyboardManagerSwift

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: Setup project
        FirebaseApp.configure()
        
        //
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
//        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
//        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
//        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
//        IQKeyboardManager.shared.shouldGroupAccessibilityChildren = true
        
        // MARK: Setup Qonversion
        let iapManager = IAPManager.shared
        iapManager.configure { success in
            if success {
                print("---- qonversion: Config success")
                iapManager.checkPermissions { success in
                    print("---- qonversion: Check permission \(success)")
                }
            } else {
                print("---- qonversion: Config failed")
            }
        }
        
        _ = ModelManagerImpl.shared
        
        // MARK: Initialize views
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // MARK: First launch settings
        
        let userDefault = UserDefaultService.shared
        
        let nav = UINavigationController(rootViewController: userDefault.isFirstLaunch ? OnboardingViewController() :  TabBarViewController())
        
        nav.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        
        // MARK: Prevent app's screen lock
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
}
