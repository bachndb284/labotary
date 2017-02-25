# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'labotary ver 1' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for labotary ver 1
	 pod 'Alamofire', '~> 4.3'
	 pod 'AlamofireImage', '~> 3.1'
	 pod 'SwiftyJSON'
	 pod 'RealmSwift'
	 pod 'ReachabilitySwift', '~> 3'
  	 pod 'RxSwift',    '~> 3.0'
   	 pod 'RxCocoa',    '~> 3.0'
  	 pod 'SlideMenuControllerSwift'
  	 pod 'ACPDownload', '~> 1.1.0'
  	 pod 'SDWebImage', '~>3.8'
	 pod ‘RxAlamofire’
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
  end
  end
end