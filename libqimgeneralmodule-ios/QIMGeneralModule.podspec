
Pod::Spec.new do |s|

  s.name         = "QIMGeneralModule"
  s.version      = "4.0.52"
  s.summary      = "Qunar chat App 6.0+ version QIMGeneralModule"
  s.description  = <<-DESC
                   Qunar QIMGeneralModule公共模块

                   DESC

  s.homepage     = "https://startalk.im"
  s.license      = "Copyright 2021 Startalk LTD."
  s.author        = { "Qunar IM" => "app@startalk.im" }

  s.source       = { :git => "https://github.com/startalkIM/libqimgeneralmodule-ios.git", :tag=> s.version.to_s}
  s.ios.deployment_target   = '9.0'

  s.platform     = :ios, "9.0"
  s.source_files = "QIMGeneralModule/QIMGeneralModuleFramework.h"
  $debug = ENV['debug']

  s.subspec 'WebRTC' do |webrtc|
    
      webrtc.resources = "QIMGeneralModule/WebRTC/RTC/icons/*.{png,jpg}", "QIMGeneralModule/WebRTC/RTC/sound/*.{mp3,wav}"
      webrtc.source_files = 'QIMGeneralModule/WebRTC/**/*.{h,m,c}', 'QIMGeneralModule/WebRTC/RTC/**/*.{h,m,c}'
#      webrtc.vendored_libraries = ['QIMGeneralModule/WebRTC/WebRTC/libWebRTC.a']
      webrtc.public_header_files = 'QIMGeneralModule/WebRTC/**/*.{h}' 'QIMGeneralModule/WebRTC/RTC/**/*.{h}'
      webrtc.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMWebRTCEnable=1'}
      webrtc.frameworks = 'VideoToolbox', 'GLKit', 'CoreTelephony', 'AVFoundation', 'UIKit', 'Foundation'
      webrtc.dependency 'SocketRocket'
      # 目前WebRTC支持iOS9的最高版本是1.1.26989
      webrtc.dependency 'GoogleWebRTC', '1.1.26989'
      webrtc.libraries = 'stdc++', 'bz2', 'resolv'

  end
  folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'

  s.subspec 'Note' do |note|

      note.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMNoteEnable=1'}
      note.public_header_files = 'QIMGeneralModule/QIMNotes/**/*.{h}'
      note.source_files = ['QIMGeneralModule/QIMNotes/ARC/**/*.{h,m,c,mm}', 'QIMGeneralModule/QIMNotes/NoARC/**/*.{h,m,c,mm}']
      note.requires_arc = false
      note.requires_arc = ['QIMGeneralModule/QIMNotes/ARC/**/*.{h,m,c,mm}']
  end

  s.subspec 'Notify' do |notify|

      notify.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMNotifyEnable=1'}
      notify.source_files = ['QIMGeneralModule/QIMNotify/**/*.{h,m,c}']
      notify.public_header_files = 'QIMGeneralModule/QIMNotify/**/*.{h}'

  end

  s.subspec 'Log' do |log|

      log.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMLogEnable=1'}
      log.source_files = ['QIMGeneralModule/QIMLocalLog/**/*.{h,m,c}']
      log.public_header_files = 'QIMGeneralModule/QIMLocalLog/**/*.{h}'

  end

  # s.subspec 'QTLog' do |qtLog|
  #     qtLog.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMLogEnable=1'}
  #     qtLog.source_files = ['QIMGeneralModule/QTLog/**/*.{h,m,c,cpp,mm}']
  #     qtLog.public_header_files = 'QIMGeneralModule/QIMLocalLog/**/*.{h}'
  #     qtLog.pod_target_xcconfig     = { "CLANG_CXX_LANGUAGE_STANDARD" => "c++11" }
  #     # qtLog.compiler_flags = folly_compiler_flags
  #     # qtLog.libraries            = "stdc++"

  # end

  # s.subspec 'QTDB' do |qtdb|
  #     qtdb.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMLogEnable=1'}
  #     qtdb.source_files = ['QIMGeneralModule/QTDataBase/**/*.{h,m,c,cpp,mm}']
  #     qtdb.public_header_files = 'QIMGeneralModule/QTDataBase/**/*.{h}'
  #     qtdb.pod_target_xcconfig     = { "CLANG_CXX_LANGUAGE_STANDARD" => "c++11" }
  #     qtdb.compiler_flags = folly_compiler_flags
  #     qtdb.libraries            = "stdc++"

  # end

  s.subspec 'Calendars' do |calendar|
      calendar.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMCalendarEnable=1'}
      calendar.source_files = ['QIMGeneralModule/QIMCalendars/**/*.{h,m,c}']
      calendar.public_header_files = 'QIMGeneralModule/QIMCalendars/**/*.{h}'
  end

  s.subspec 'AutoMonitor' do |monitor|
    monitor.source_files = 'QIMGeneralModule/QIMMonitor/**/*.{h,m}'
    monitor.public_header_files = 'QIMGeneralModule/QIMMonitor/**/.h'
  end

  if $debug
    puts 'debug QIMGeneralModule'

  else

    puts '线上release QIMGeneralModule依赖第三方库'
      s.dependency 'QIMCommon', '~> 4.0'
      s.dependency 'QIMOpenSSL'
      s.dependency 'QIMKitVendor', '~> 4.0'
      s.dependency 'QIMCommonCategories', '~> 4.0'
  end
  

  s.dependency 'SCLAlertView-Objective-C'
  s.dependency 'Masonry'

  s.frameworks = 'Foundation', 'UIKit', 'AVFoundation', 'CoreTelephony'

end
