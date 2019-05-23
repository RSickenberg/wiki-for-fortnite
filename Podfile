project 'fort-to-nite.xcodeproj'
# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'fort-to-nite' do
  use_frameworks!

  # Pods for fortnite_wik
  pod 'Crashlytics'
  pod 'ChameleonFramework/Swift' , :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'Alamofire'
  pod 'PKHUD'
  pod 'AlamofireImage'
  pod 'StatusAlert', '~> 0.12.1'
  pod 'WhatsNewKit', '~> 1.1.3'
  pod 'SwiftSpinner'
  pod 'Siren', '~> 3.9.1'
  pod 'Peek', :configurations => ['Debug']
  # pod "CenteredCollectionView" or https://github.com/VladIacobIonut/Swinflate to rework store
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'StatusAlert'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end
end
