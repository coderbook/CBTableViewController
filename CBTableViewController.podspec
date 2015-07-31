#
# Be sure to run `pod lib lint demolib.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CBTableViewController"
  s.version          = "0.0.1"
  s.summary          = "easy using mjrefresh for refreshing and load more data"
  s.description      = <<-DESC
                       By using CBTableviewController you can add refresh or load more page features on your apps 
                       * 
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/coderbook/CBTableViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'CoderBook'
  s.author           = { "coderbook" => "ying.wang" }
  s.source           = { :git => "https://github.com/coderbook/CBTableViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'CBTableViewController/**/*'
#s.resource_bundles = {
#    'demolib' => ['Pod/Assets/*.png']
# }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
s.dependency 'MJRefresh'
s.dependency 'MJExtension'
end
