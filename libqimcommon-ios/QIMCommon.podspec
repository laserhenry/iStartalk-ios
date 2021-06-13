Pod::Spec.new do |s|

  s.name         = "QIMCommon"
  s.version      = "4.0.52"
  s.summary      = "Qunar chat App 9.0+ version QIMCommon"
  s.description  = <<-DESC
                   Qunar QIMPubCommon解决方案

                   DESC

  s.homepage     = "https://www.startalk.im"
  s.license      = "Copyright 2021 Startalk Inc."
  s.author        = { "Qunar IM" => "app@startalk.im" }

  s.source       = { :git => "https://github.com/startalkIM/libqimcommon-ios.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '9.0'
  s.resource_bundles = {'QIMCommonResource' => ['QIMCommon/QIMKitCommonResource/*.{png,aac,caf,pem,wav}']}

  s.platform     = :ios, "9.0"
  
  s.subspec 'QIMPrivatePBCommon' do |pbcommon|
    pbcommon.source_files = 'QIMCommon/QIMPrivatePBCommonFramework/Headers/**/*.{h,m,c}'
    pbcommon.vendored_libraries = ['QIMCommon/QIMPrivatePBCommonFramework/Frameworks/libQIMPrivatePBCommon.a']
    pbcommon.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}
  end

  s.subspec 'Base' do |base|
    $lib = ENV['use_lib']
    $debug = ENV['debug']
    if $lib
      
      puts '---------QIMCommonSDK二进制-------'
      base.source_files = 'ios_libs/Headers/**/*.h'
      base.vendored_libraries = ['ios_libs/Frameworks/libQIMCommon.a']
      base.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}
      
      else
      
      puts '---------QIMCommonSDK源码-------'
      s.public_header_files = "QIMCommon/QIMKit/**/*.{h}", "QIMCommon/QIMDB/**/*.{h}"

      s.source_files = "QIMCommon/Source/**/*.{h,m,c}", "QIMCommon/QIMKit/**/*.{h,m,c}", "QIMCommon/QIMDB/**/*.{h,m,mm}"
      s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'DEBUGLOG=1'}

    end
  end

  if $debug
    puts 'debug QIMCommon依赖第三方库'
    s.dependency 'QIMOpenSSL'
    s.default_subspecs = 'Base'
    s.default_subspecs = 'Base', 'QIMPrivatePBCommon'

  else
  
    puts '线上release QIMPubCommon依赖第三方库'
    s.dependency 'QIMOpenSSL'
    s.dependency 'QIMKitVendor'
    s.dependency 'QIMDataBase'
    s.default_subspecs = 'Base', 'QIMPrivatePBCommon'
  end
  
  s.dependency 'YYCache'
  s.dependency 'YYModel'
  s.dependency 'ProtocolBuffers'
  s.dependency 'CocoaAsyncSocket'
  s.dependency 'UICKeyChainStore'
  s.dependency 'YYDispatchQueuePool'
  # 避免崩溃
  s.dependency 'AvoidCrash'
  
  s.dependency 'CocoaLumberjack'
  s.dependency 'WCDB'

  s.frameworks = 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AudioToolbox', 'AVFoundation', 'UserNotifications', 'CoreTelephony','QuartzCore', 'CoreGraphics', 'Security'
  s.libraries = 'stdc++','bz2'
end
