#
# Be sure to run `pod lib lint SmoothLineView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SmoothLineView"
  s.version          = "0.1.11"
  s.summary          = "Smooth line drawing for iOS"
  s.description      = <<-DESC
Smooth & fast line drawing from touch inputs for UIViews using Quartz

                       DESC
  s.homepage         = "https://github.com/kompozer/SmoothLineView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.authors          = { "Levi Nunnink" => "https://github.com/levinunnink", "Andreas Kompanez" => "https://twitter.com/kompozer" }
  s.source           = { :git => "https://github.com/kompozer/SmoothLineView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kompozer'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SmoothLineView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
