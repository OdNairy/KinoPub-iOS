platform :ios, '13.0'

target 'KinoPub' do

  use_frameworks!
  inhibit_all_warnings!
  # pod 'Crashlytics'
  # pod 'Fabric'
  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireImage'
  pod 'AlamofireNetworkActivityLogger'
  pod 'AlamofireObjectMapper'
  pod 'CircleProgressView'
  pod 'CustomLoader'
  pod 'DGCollectionViewPaginableBehavior'
  pod 'EasyAbout'
  pod 'Eureka'
  pod 'InteractiveSideMenu', :git => 'https://github.com/handsomecode/InteractiveSideMenu.git', :branch => 'master'
  pod 'KeychainSwift'
  pod 'LKAlertController'
  pod 'NDYoutubePlayer', :git => 'https://github.com/hintoz/NDYoutubePlayer.git'
  pod 'NotificationBannerSwift'
  pod 'RevealingSplashView'
  pod 'SubtleVolume'
  pod 'SwifterSwift'
  pod 'SwiftyUserDefaults', '~> 3.0'

  # Local
  pod 'NTDownload', :path => 'Dependencies/NTDownload' # :git => 'https://github.com/hintoz/NTDownload.git'
  pod 'AZSearchView', path: 'Dependencies/AZSearchView' # :git => 'https://github.com/hintoz/AZSearchView.git'
  pod 'TMDBSwift', :path => 'Dependencies/TheMovieDatabaseSwiftWrapper' # :git => 'https://github.com/gkye/TheMovieDatabaseSwiftWrapper.git', branch: 'master'
  pod 'EZPlayer', :path => 'Dependencies/EZPlayer' # :git => 'https://github.com/hintoz/EZPlayer.git'
  pod 'Letters', :path => 'Dependencies/Swift-UIImageView-Letters'

  # Updated
  pod 'GradientLoadingBar'

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
				config.build_settings['SWIFT_VERSION'] = '5.0'
			end
		end

    case target.name
    when 'TMDBSwift'
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end

    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end

	end
end
