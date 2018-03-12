#
# Be sure to run `pod lib lint RateMe.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RateMe'
  s.version          = '1.0.1'
  s.summary          = 'RateMe helps you to track your users and warn you when the application is used by a satisfied user.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Getting five star comments are very important for every application. RateMe helps you to track your users and warn you when the application is used by a satisfied user. RateMe is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:
                       DESC

  s.homepage         = 'https://github.com/zingat/RateMe-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kadirkemal' => 'kkdursun@yahoo.com' }
  s.source           = { :git => 'https://github.com/zingat/RateMe-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RateMe/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RateMe' => ['RateMe/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
