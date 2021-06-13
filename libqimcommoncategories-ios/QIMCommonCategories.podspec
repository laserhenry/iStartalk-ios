
Pod::Spec.new do |s|

  s.name         = "QIMCommonCategories"
  s.version      = "4.0.55"
  s.summary      = "Qunar chat App 6.0+ version QIMCommonCategories"
  s.description  = <<-DESC
                   Qunar QIMCommonCategories解决方案

                   DESC

  s.homepage     = "https://www.startalk.im"
  s.license      = "Copyright 2021 Startalk Inc."
  s.author        = { "Qunar IM" => "app@startalk.im" }

  s.source       = { :git => "https://github.com/startalkIM/libqimcommoncategories-ios.git", :tag => s.version.to_s}

  s.ios.deployment_target   = '9.0'


  s.platform     = :ios, "9.0"

  s.public_header_files = "QIMCommonCategories/**/*.{h}"
  s.source_files = "QIMCommonCategories/**/*.{h,m,c}"
  s.xcconfig = {'BITCODE_GENERATION_MODE' => 'bitcode'}
  s.pod_target_xcconfig = {
    "APPLICATION_EXTENSION_API_ONLY" => "YES",
  }
  s.frameworks = 'UIKit', 'Foundation', 'CoreFoundation', 'ImageIO'
end
