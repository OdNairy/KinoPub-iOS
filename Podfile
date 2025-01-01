platform :ios, '9.0'

target 'KinoPub' do

  use_frameworks!
  inhibit_all_warnings!
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'AlamofireNetworkActivityLogger'
  pod 'AlamofireImage'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SwiftyUserDefaults'
  pod 'KeychainSwift'
  pod 'LKAlertController'
  pod 'InteractiveSideMenu'
  pod 'SwifterSwift'
  pod 'DGCollectionViewPaginableBehavior'
  pod 'Atributika'
  # pod 'EZPlayer', :git => 'https://github.com/hintoz/EZPlayer.git'
  pod 'EZPlayer', :path => 'Dependencies/EZPlayer'
  pod 'Letters'
  pod 'RevealingSplashView'
  pod 'TMDBSwift', :git => 'https://github.com/gkye/TheMovieDatabaseSwiftWrapper.git'
  # pod 'TMDBSwift', :path => 'Dependencies/TheMovieDatabaseSwiftWrapper'
  pod 'SubtleVolume'
  pod 'CustomLoader'
  pod 'NotificationBannerSwift'
  pod 'Eureka'
  # pod 'NTDownload', :git => 'https://github.com/hintoz/NTDownload.git'
  pod 'NTDownload', :path => 'Dependencies/NTDownload'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Firebase/RemoteConfig'
  pod 'AZSearchView', :git => 'https://github.com/hintoz/AZSearchView.git'
  pod 'NDYoutubePlayer', :git => 'https://github.com/hintoz/NDYoutubePlayer.git'
  pod 'GradientLoadingBar'
  pod 'EasyAbout'
  pod 'CircleProgressView'

  pod 'R.swift'
end

# post_install do |installer|
# 	myTargets = ['CustomLoader', 'DGCollectionViewPaginableBehavior']

# 	installer.pods_project.targets.each do |target|
# 		if myTargets.include? target.name
# 			target.build_configurations.each do |config|
# 				config.build_settings['SWIFT_VERSION'] = '3.2'
# 			end
# 		end
# 	end
# end

post_install do |installer|
	myTargets = ['InteractiveSideMenu']

	installer.pods_project.targets.each do |target|
		if myTargets.include? target.name
			target.build_configurations.each do |config|
				config.build_settings['SWIFT_VERSION'] = '4.2'
			end
		end
	end
end
