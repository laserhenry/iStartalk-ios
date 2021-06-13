#
# Be sure to run `pod lib lint QRCodeGenerator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QRCodeGenerator'
  s.summary          = 'QRCodeGenerator pod.'
  s.description      = <<-DESC
  QRCodeGenerator pod used by iOS Dev Team.
                       DESC

s.homepage         = 'https://github.com/gscarrone/iOS-QR-Code-Generator'
s.license          = { :type => 'MIT' }
s.author           = { '' => '' }

s.ios.deployment_target = '8.0'


s.version = '1.SourceCode'
s.source = { :git => 'https://github.com/gscarrone/iOS-QR-Code-Generator.git', :tag => s.version.to_s }
s.source_files = 'class/**/*.{h,m,mm,c,cpp}'

end
