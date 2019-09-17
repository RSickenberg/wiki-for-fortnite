project 'fort-to-nite.xcodeproj'
# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'fort-to-nite' do
  use_frameworks!

  # Pods for fortnite_wik
  pod 'Crashlytics'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/pommes/Chameleon.git'
  pod 'Alamofire'
  pod 'PKHUD'
  pod 'AlamofireImage'
  pod 'StatusAlert', '~> 0.12.1'
  pod 'WhatsNewKit'
  pod 'SwiftSpinner'
  pod 'Siren'
  pod 'SwiftGen', '~> 5.3'
  
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
          end
      end
  end
  
  pre_install do |installer|
      installer.analysis_result.specifications.each do |s|
          s.swift_version = '5.0' unless s.swift_version
      end
  end
end
