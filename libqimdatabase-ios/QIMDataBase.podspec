
Pod::Spec.new do |s|


  s.name         = "QIMDataBase"
  s.version      = "4.0.55"
  s.summary      = "Qunar chat App 6.0+ version QIMKitVendor"

  s.description  = <<-DESC
                   Qunar QIMDataBase解决方案

                   DESC

  s.homepage     = "https://startalk.im"
  s.license      = "Copyright 2015 Startalk Inc."
  s.author        = { "qunar mobile" => "app@startalk.im" }
  s.source       = { :git => "https://github.com/startalkIM/libqimdatabase-ios.git", :tag=> s.version.to_s}
  s.ios.deployment_target   = '9.0'

  s.source_files = 'QIMDataBase/**/*.{h,m,c}'
#  s.requires_arc = false
  s.libraries = 'sqlite3.0'

end
