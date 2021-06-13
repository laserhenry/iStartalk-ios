
Pod::Spec.new do |s|


  s.name         = "QIMKitVendor"
  s.version      = "4.0.53"
  s.summary      = "Qunar chat App 9.0+ version QIMKitVendor"

  s.description  = <<-DESC
                   Qunar QIMKitVendor解决方案

                   DESC

  s.homepage     = "http://www.im.qunar.com"
  s.license      = "Copyright 2015 Qunar.com"
  s.author        = { "qunar mobile" => "QIMKitVendor@qunar.com" }
  s.source       = { :git => "https://github.com/startalkIM/libqimkitvendor-ios.git", :tag=> s.version.to_s}
  s.ios.deployment_target   = '9.0'

  $debug = ENV['debug']
 
  s.subspec 'PublicRedefineHeader' do |prHeader|
      prHeader.source_files = "QIMKitVendor/QIMPublicRedefineHeader/QIMPublicRedefineHeader.h"    
  end

  s.subspec 'Helper' do |helper|
    helper.source_files = 'QIMKitVendor/QIMHelper/**/*.{h,m,c}'
    helper.dependency 'QIMKitVendor/PublicRedefineHeader'
  end

  s.subspec 'Audio' do |audio|
    
    audio.source_files = 'QIMKitVendor/Audio/**/*.{h,m,c}', 'QIMKitVendor/Audio/include/**/*.{h,m,c}'
    audio.vendored_libraries = ['QIMKitVendor/Audio/opencore-amr/lib/libopencore-amrnb.a',
                                'QIMKitVendor/Audio/opencore-amr/lib/libopencore-amrwb.a']
    audio.requires_arc = false
    audio.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMAudioEnable=1'}
    audio.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
#  s.subspec 'ZBar' do |zbar|
#      zbar.source_files = 'QIMKitVendor/QIMZBarSDK/Headers/ZBarSDK/zbar/*.{h,m,c}', 'QIMKitVendor/QIMZBarSDK/Headers/ZBarSDK/*.{h,m,c}', 'QIMKitVendor/QIMZBarSDK/libqrencode/**/*.{h,m,c}'
#      zbar.vendored_libraries = ['QIMKitVendor/QIMZBarSDK/libzbar.a']
#      zbar.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMKitVendor/**\" \"${PODS_ROOT}/Headers/Public/QIMKitVendor/**\" \"${PODS_ROOT}/Headers/Public/QIMKitVendor/**\""}
#      zbar.frameworks = 'AVFoundation', 'CoreGraphics', 'CoreMedia', 'CoreVideo', 'QuartzCore'
#      zbar.libraries = 'iconv'
#      zbar.dependency 'QIMKitVendor/PublicRedefineHeader'
#  end
  
  s.subspec 'Zip' do |zip|

      zip.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMZipEnable=1'}
      zip.source_files = ['QIMKitVendor/QIMZipArchive/**/*{h,m,c}']
      zip.dependency 'QIMKitVendor/PublicRedefineHeader'
  end

  s.subspec 'PinYin' do |pinyin|

    pinyin.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMPinYinEnable=1'}
    pinyin.source_files = ['QIMKitVendor/QIMPinYin/**/*{h,m,c}']
    pinyin.resource_bundles = {'QIMPinYin' => ['QIMKitVendor/QIMPinYin/unicode_to_hanyu_qim_pinyin.txt']}
    pinyin.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
  s.subspec 'JSON' do |json|
      
      json.public_header_files = 'QIMKitVendor/QIMJSON/**/*.{h}'
      json.source_files = ['QIMKitVendor/QIMJSON/**/*.{h,m,c}']
      json.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
  s.subspec 'DOG' do |dog|
      
      dog.public_header_files = 'QIMKitVendor/QIMWatchDog/**/*.{h}'
      dog.source_files = ['QIMKitVendor/QIMWatchDog/**/*.{h,m,c}']
      dog.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
  s.subspec 'UUID' do |uuid|
      
      uuid.public_header_files = 'QIMKitVendor/QIMUUID/**/*.{h}'
      uuid.source_files = ['QIMKitVendor/QIMUUID/**/*.{h,m,c}']
      uuid.dependency 'UICKeyChainStore'
      uuid.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
  s.subspec 'DES' do |des|
      
      des.public_header_files = 'QIMKitVendor/QIMDES/**/*.{h}'
      des.source_files = ['QIMKitVendor/QIMDES/**/*.{h,m,c}']
      des.dependency 'QIMKitVendor/PublicRedefineHeader'
  end
  
#  s.subspec 'ASI' do |asi|
#    asi.requires_arc = false;
#    asi.dependency 'Reachability'
#    asi.source_files = ['QIMKitVendor/QIMASI/**/*.{h,m,c}']
#    asi.frameworks = 'MobileCoreServices', 'CFNetwork', 'CoreGraphics', 'SystemConfiguration', 'CoreServices'
#    asi.libraries = 'z.1', 'xml2.2'
#    asi.xcconfig = {
#      'HEADER_SEARCH_PATHS': "$(SDKROOT)/usr/include/libxml2"
#    }
#  end

  s.subspec 'HTTP' do |http|
      
      http.public_header_files = 'QIMKitVendor/QIMHTTP/**/*.{h}'
      http.source_files = ['QIMKitVendor/QIMHTTP/**/*.{h,m,c}']
#      http.dependency 'QIMKitVendor/ASI'
      http.dependency 'AFNetworking'
      http.dependency 'QIMKitVendor/JSON'
      http.dependency 'QIMKitVendor/DOG'
      http.dependency 'QIMKitVendor/PublicRedefineHeader'      
  end

  s.subspec 'GCD' do |gcd|
    
    gcd.public_header_files = 'QIMKitVendor/GCD/**/*.{h}'
    gcd.source_files = ['QIMKitVendor/GCD/**/*.{h,m,c}']
    gcd.requires_arc = false  
    gcd.dependency 'QIMKitVendor/PublicRedefineHeader'
  end

  s.subspec 'libwebp' do |libwebp|
    libwebp.requires_arc = false
    libwebp.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMKitVendor/**\" \"${PODS_ROOT}/Headers/Public/QIMKitVendor/**\" \"${PODS_ROOT}/Headers/Public/QIMKitVendor/**\""}

#    libwebp.pod_target_xcconfig = {
#      "USER_HEADER_SEARCH_PATHS": "$(inherited) ${PODS_ROOT}/QIMKitVendor/**"
#    }
    libwebp.header_dir = 'webp'
    libwebp.source_files = 'QIMKitVendor/QIMLibwebp/src/**/*{h,c}'
  end
  
#  s.subspec 'SDWebImage' do |sdwebImage|
#    sdwebImage.source_files = 'QIMKitVendor/QIMSDWebImage/{NS,SD,UI,QIM}*.{h,m}'
#    sdwebImage.exclude_files = 'QIMKitVendor/QIMSDWebImage/UIImage+WebP.{h,m}'
#    sdwebImage.tvos.exclude_files = 'QIMKitVendor/QIMSDWebImage/MKAnnotationView+WebCache.*'
#    sdwebImage.framework = 'ImageIO'
#  end

#  s.subspec 'OPENSSL' do |openssl|
#    openssl.ios.source_files        = 'QIMKitVendor/QIMOpenSSL/include-ios/openssl/**/*.h'
#    openssl.ios.public_header_files = 'QIMKitVendor/QIMOpenSSL/include-ios/openssl/**/*.h'
#    openssl.ios.header_dir          = 'QIMKitVendor/QIMOpenSSL/openssl'
#    openssl.ios.preserve_paths      = 'QIMKitVendor/QIMOpenSSL/lib-ios/libcrypto.a', 'QIMKitVendor/QIMOpenSSL/lib-ios/libssl.a'
#    openssl.ios.vendored_libraries  = 'QIMKitVendor/QIMOpenSSL/lib-ios/libcrypto.a', 'QIMKitVendor/QIMOpenSSL/lib-ios/libssl.a'
#
#    openssl.libraries = 'ssl', 'crypto'
#    openssl.requires_arc = false
#
#  end

  s.pod_target_xcconfig = {
    "APPLICATION_EXTENSION_API_ONLY" => "NO",
  }
  s.frameworks = 'Foundation', 'UIKit', 'AVFoundation', 'CoreTelephony', 'AVFoundation'
  
  if $debug
    puts 'debug QIMKitVendor依赖第三方库'

  else

    puts '线上release QIMKitVendor依赖第三方库'
    s.dependency 'QIMCommonCategories', '~> 4.0'
  end
  
  s.dependency 'ZipArchive'
  s.dependency 'CocoaLumberjack'
  s.dependency 'Reachability'
  
end
