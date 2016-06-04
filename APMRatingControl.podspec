#
# Be sure to run `pod lib lint APMRatingControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "APMRatingControl"
  s.version          = "0.2.1"
  s.summary          = "Rating control written in Swift"

  s.description      = <<-DESC
   Rating star control view
                       DESC

  s.homepage         = "https://github.com/almas-dev/APMRatingControl"
  s.license          = 'MIT'
  s.author           = { "Alexander Maslennikov" => "almas.dev@gmail.com" }
  s.source           = { :git => "https://github.com/almas-dev/APMRatingControl.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'APMRatingControl' => ['Pod/Assets/*.png']
  }
end
