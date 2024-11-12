#
# Be sure to run `pod lib lint APIServiceLayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APIServiceLayer'
  s.version          = '0.1.0'
  s.summary          = 'APIServiceLayer is a Swift networking library that simplifies making API requests and handling responses.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  'NetworkLayer is a Swift networking library that simplifies making API requests and handling responses. It includes a singleton NetworkManager for global use, and an APIHandler class for managing network calls with Combine. The library supports reactive programming with Swift’s Combine framework, and provides clear, custom error handling through a NetworkError enum. It ensures easy-to-manage networking, clean data decoding, and error mapping, making it ideal for Swift applications that require robust network communication.'
                       DESC

  s.homepage         = 'https://github.com/SakethReddy-Pundru/APIServiceLayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SakethReddy-Pundru' => 'pundrusakethreddy@gmail.com' }
  s.source           = { :git => 'https://github.com/SakethReddy-Pundru/APIServiceLayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'

  s.source_files = 'Classes/**/*.swift'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'APIServiceLayer' => ['APIServiceLayer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
