# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Roompi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Roompi
	pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'
	pod 'Alamofire', '~> 5.2'
  pod 'RxAlamofire'
  pod 'ObjectMapper'
  pod 'SwiftyJSON'
  pod 'SwiftMessages'
  pod 'Material'
  pod 'SnapKit'

  target 'RoompiTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RoompiUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('8.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
