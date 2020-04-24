#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutterumeng.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutterumeng'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter  umeng plugin.'
  s.description      = <<-DESC
A new Flutter  umeng plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  
  # 基础库
  s.dependency 'UMCCommon','2.1.4'
  
  # 分享依赖库
  s.dependency 'UMCSecurityPlugins','1.0.6'
  
  # 日志打印
  s.dependency 'UMCCommonLog','1.0.0'
  
 # U-Share SDK UI模块（分享面板，建议添加）
  s.dependency 'UMCShare/UI','6.9.8'

  # 集成微信(精简版0.2M)
  s.dependency 'UMCShare/Social/ReducedWeChat','6.9.8'

  # 集成微信(完整版14.4M)
#  s.dependency 'UMCShare/Social/WeChat'

  # 集成QQ/QZone/TIM(精简版0.5M)
  s.dependency 'UMCShare/Social/ReducedQQ','6.9.8'

  # 集成QQ/QZone/TIM(完整版7.6M)
#  s.dependency 'UMCShare/Social/QQ'

  # 集成新浪微博(精简版1M)
  s.dependency 'UMCShare/Social/ReducedSina','6.9.8'

  # 集成新浪微博(完整版25.3M)
#  s.dependency 'UMCShare/Social/Sina'


  # 集成支付宝
#  s.dependency 'UMCShare/Social/AlipayShare'

  # 集成钉钉
  s.dependency 'UMCShare/Social/DingDing','6.9.8'


   
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.static_framework = true


end
