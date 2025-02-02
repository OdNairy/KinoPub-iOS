platform :ios, '13.0'

target 'KinoPub' do

  use_frameworks!
  inhibit_all_warnings!
  # pod 'Crashlytics'
  # pod 'Fabric'

  pod 'Alamofire', '~> 5.0'
  pod 'AlamofireImage'
  pod 'AlamofireNetworkActivityLogger'
  pod 'NotificationBannerSwift' # outdated
  pod 'SwifterSwift'
  pod 'SwiftyUserDefaults', '~> 3.0'

  # Local
  pod 'NTDownload', :path => 'Dependencies/NTDownload' # :git => 'https://github.com/hintoz/NTDownload.git'
  pod 'AZSearchView', path: 'Dependencies/AZSearchView' # :git => 'https://github.com/hintoz/AZSearchView.git'
  pod 'TMDBSwift', :path => 'Dependencies/TheMovieDatabaseSwiftWrapper' # :git => 'https://github.com/gkye/TheMovieDatabaseSwiftWrapper.git', branch: 'master'
  pod 'EZPlayer', :path => 'Dependencies/EZPlayer' # :git => 'https://github.com/hintoz/EZPlayer.git'
  pod 'Letters', :path => 'Dependencies/Swift-UIImageView-Letters'

  # Updated
  pod 'SubtleVolume'
  pod 'RevealingSplashView'
  pod 'LKAlertController'
  pod 'KeychainSwift'
  pod 'InteractiveSideMenu', :git => 'https://github.com/handsomecode/InteractiveSideMenu.git', :branch => 'master'
  pod 'CircleProgressView'
  pod 'CustomLoader'
  pod 'DGCollectionViewPaginableBehavior'
  pod 'EasyAbout'
  pod 'Eureka'
  pod 'GradientLoadingBar'

end

post_install do |installer|
	myTargets = ['InteractiveSideMenu']

	installer.pods_project.targets.each do |target|
		if myTargets.include? target.name
			target.build_configurations.each do |config|
				config.build_settings['SWIFT_VERSION'] = '5.0'
			end
		end

    target.build_configurations.each do |config|

      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0' if target.name == 'TMDBSwift'
      originalDeploymentTarget = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      newDeploymentTarget = '12.0'

      if Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']) < Gem::Version.new(newDeploymentTarget)
        puts "Bump from #{originalDeploymentTarget} to #{newDeploymentTarget} \t[#{target.name}]" if config.name == 'Debug'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = newDeploymentTarget
      end

    end

	end
end
