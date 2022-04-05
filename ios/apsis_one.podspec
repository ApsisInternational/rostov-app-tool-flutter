Pod::Spec.new do |s|
  s.name             = 'apsis_one'
  s.version          = '0.0.2'
  s.summary          = 'Flutter wrapper for ApsisOne iOS SDK'
  s.homepage         = 'https://apsis.com'
  s.license          = { :type => 'Custom', :file => '../LICENSE' }
  s.authors          = 'APSIS International AB'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ApsisOne', '~> 0.8.2'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
