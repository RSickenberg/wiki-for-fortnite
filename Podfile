project 'fort-to-nite.xcodeproj'
# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

target 'fort-to-nite' do
  use_frameworks!

  # Pods for fortnite_wik
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/pommes/Chameleon.git'
  pod 'Alamofire'
  pod 'PKHUD'
  pod 'AlamofireImage'
  pod 'StatusAlert', '~> 0.12.1'
  pod 'WhatsNewKit'
  pod 'SwiftSpinner'
  pod 'Siren'
  pod 'SwiftGen', '~> 5.3'

#  pod 'Firebase/Analytics'
  pod 'Firebase/Performance'
  pod 'Firebase/Crashlytics'
  pod 'Fabric'
  pod "SwiftMessages"
  
  # pod "CenteredCollectionView" or https://github.com/VladIacobIonut/Swinflate to rework store
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '5.0'
          end
          if target.name == 'StatusAlert' || target.name == 'ChameleonFramework'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
              if target.name.start_with?("Pods")
                  puts "Updating #{target.name} to exclude Crashlytics/Fabric"
                  target.build_configurations.each do |config|
                      xcconfig_path = config.base_configuration_reference.real_path
                      xcconfig = File.read(xcconfig_path)
                      xcconfig.sub!('-framework "FirebaseAnalytics"', '')
                      xcconfig.sub!('-framework "FIRAnalyticsConnector"', '')
                      xcconfig.sub!('-framework "GoogleMobileAds"', '')
                      xcconfig.sub!('-framework "Google-Mobile-Ads-SDK"', '')
                      xcconfig.sub!('-framework "GoogleAppMeasurement"', '')
                      xcconfig.sub!('-framework "Fabric"', '')
                      new_xcconfig = xcconfig + 'OTHER_LDFLAGS[sdk=iphone*] = $(inherited) -framework "FirebaseAnalytics"  -framework "FIRAnalyticsConnector"  -framework "GoogleMobileAds" -framework "GoogleAppMeasurement" -framework "GoogleUtilities" "-AppMeasurement" -framework "Fabric"'
                      File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
                  end
              end
          end
      end
  end
  
  pre_install do |installer|
      installer.analysis_result.specifications.each do |s|
          s.swift_version = '5.0' unless s.swift_version
      end
  end
end

target 'fort-to-nite-catalyst' do
    use_frameworks!

    pod 'ChameleonFramework/Swift', :git => 'https://github.com/pommes/Chameleon.git'
    pod 'Alamofire'
    pod 'PKHUD'
    pod 'AlamofireImage'
    pod 'StatusAlert', '~> 0.12.1'
    pod 'WhatsNewKit'
    pod 'SwiftSpinner'
    pod 'Siren'
    pod 'SwiftGen', '~> 5.3'
    pod "SwiftMessages"
end
