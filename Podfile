platform :ios, '13.0'

target 'KinoPub' do

  use_frameworks!
  inhibit_all_warnings!
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'AlamofireNetworkActivityLogger'
  pod 'AlamofireImage'
  # pod 'Fabric'
  # pod 'Crashlytics'
  pod 'SwiftyUserDefaults', '~> 3.0'
  pod 'KeychainSwift'
  pod 'LKAlertController'
  pod 'InteractiveSideMenu', :git => 'https://github.com/handsomecode/InteractiveSideMenu.git', :branch => 'master'
  # pod 'InteractiveSideMenu', :path => 'Dependencies/InteractiveSideMenu'
  pod 'SwifterSwift'
  pod 'DGCollectionViewPaginableBehavior'
  pod 'Atributika'
  # pod 'EZPlayer', :git => 'https://github.com/hintoz/EZPlayer.git'
  pod 'EZPlayer', :path => 'Dependencies/EZPlayer'
  # pod 'Letters'
  pod 'Letters', :path => 'Dependencies/Swift-UIImageView-Letters'
  pod 'RevealingSplashView'
  # pod 'TMDBSwift', :git => 'https://github.com/gkye/TheMovieDatabaseSwiftWrapper.git', branch: 'master'
  pod 'TMDBSwift', :path => 'Dependencies/TheMovieDatabaseSwiftWrapper'
  pod 'SubtleVolume'
  pod 'CustomLoader'
  pod 'NotificationBannerSwift'
  pod 'Eureka'
  # pod 'NTDownload', :git => 'https://github.com/hintoz/NTDownload.git'
  pod 'NTDownload', :path => 'Dependencies/NTDownload'
  pod 'AZSearchView', path: 'Dependencies/AZSearchView'
  # pod 'AZSearchView', :git => 'https://github.com/hintoz/AZSearchView.git'
  pod 'NDYoutubePlayer', :git => 'https://github.com/hintoz/NDYoutubePlayer.git'
  pod 'GradientLoadingBar', '~> 1.0'
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
