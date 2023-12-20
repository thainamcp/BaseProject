import UIKit
import StoreKit
import Alamofire

struct Developer {
    static let itcAppID = "6446304020"
    static let urlApp = "https://apps.apple.com/vn/app/midful-talk-motivation-app/id\(Developer.itcAppID)"
    static let supportEmail = "admin@tinyleo.com"
    static let conntacUs = "https://sites.google.com/tinyleo.com/contact-us"
    static let privacyPolicy = "https://sites.google.com/tinyleo.com/privacy-policy"
    static let termOfUse = "https://sites.google.com/tinyleo.com/terms-of-use"
    static let bundleID = Bundle.main.bundleIdentifier!
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    // alert
    static let titleAlert = "Notification"
    static let messageAlert = "Do you really want to delete this?"
    
    //
    static let cornerRadius20 = 20.scaleX
    
    // API
    static let domain = "https://mindfultalk.tinyleo.com/api/v1"
    static let endpointChat = "/chat"
    static let endpointGenImage = "/images/generations"
    
    // qonversion
    static let qonversionKey = "PgapaGTi1ws6DqMfjIdB7zn9iF6W1t0i"
    static let lifetimeProduct = "lifetime"
    static let monthlyProduct = "monthly"
    static let weeklyProduct = "weekly"
    
    static let defaultPrompt = "best quality, ultra-detailed, illustration, anime style, "
    static let ratio = UIScreen.main.bounds.width / 375.0
    static let isHasNortch: Bool = {
        let size = UIScreen.main.bounds.size
        return size.width / size.height < 375.0 / 667.0
    }()
    
#if DEBUG && canImport(GoogleMobileAds)
    static let testDevices: [String] = ["kGADSimulatorID"]
#else
    static let testDevices: [String] = []
#endif
    
}

struct AdMob {
    static var bannerAdId: String {
#if DEBUG
        return "ca-app-pub-3940256099942544/2934735716"
#else
        return "ca-app-pub-4867765339642009/5698977872"
#endif
    }
    
    static var rewardedAdId: String {
#if DEBUG
        return "ca-app-pub-3940256099942544/1712485313"
#else
        return "ca-app-pub-4867765339642009/4339710466"
#endif
    }
}

enum IAP: String, CaseIterable {
    case lifetime
    
    var productID: String {
        switch self {
        case .lifetime:
            return "\(Developer.bundleID).\(self.rawValue)"
        }
    }
}

func showReview() {
#if !DEBUG
    if let scene = UIApplication.shared.currentScene {
        SKStoreReviewController.requestReview(in: scene)
    }
#endif
}

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}

enum LayoutMode: String, Codable {
    case light, dark
}
