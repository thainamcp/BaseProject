platform :ios, '14.0'
use_frameworks!

# Define shared library for all target.
def common_pods
  pod 'RxSwift', '6.1.0'
  pod 'RxCocoa', '6.1.0'
  pod 'SnapKit'
  pod 'Purchases'
  pod 'ProgressHUD'
  pod 'R.swift'
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git',  :branch => 'alamofire5'
  pod 'NVActivityIndicatorView'
  pod 'MailController', '~> 1.0'
  pod 'Qonversion', '2.21.1'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Google-Mobile-Ads-SDK'
  pod 'Firebase'
  pod 'Firebase/RemoteConfig'
  pod 'Kingfisher', '~> 7.0'
  pod 'IQKeyboardManagerSwift', '6.3.0'
  pod 'SlidableImage', '~>2.0'
  pod 'Hero'
  pod 'SwiftJWT'
  pod 'GrowingTextView', '0.7.2'
end

target 'AODApp' do
  inhibit_all_warnings!
  
  common_pods
   
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
      end
    end
  end
end
