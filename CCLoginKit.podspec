#
# Be sure to run `pod lib lint CCLoginKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CCLoginKit'
  s.version          = '0.1.7'
  s.summary          = '登录组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  登录组件：登录、注册、忘记密码、切换角色登录、找回支付和登录密码
                       DESC

  s.homepage         = 'https://github.com/BoASir/CCLoginKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BoASir' => '992816613@qq.com' }
  s.source           = { :git => 'https://github.com/BoASir/CCLoginKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CCLoginKit/Classes/**/*'
  
  #s.resource_bundles = {
  #  'CCLoginKit' => ['CCLoginKit/Assets/*.png']
  #}
  # s.resources = 'CCLoginKit/Assets/CCLoginResource.bundle'
  s.resources = 'CCLoginKit/Assets/**/*'
  s.public_header_files = 'CCLoginKit/Classes/**/*.h'
   s.frameworks = 'UIKit','Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'bench_ios'
end
