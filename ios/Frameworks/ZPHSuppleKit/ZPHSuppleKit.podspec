
Pod::Spec.new do |s|
  s.name             = 'ZPHSuppleKit'
  s.version          = '0.0.1'
  s.summary          = 'supple test'

  s.description      = <<-DESC
supple test description.
                       DESC

  s.homepage         = 'https://github.com/semperhhh/ZPHSuppleKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zphui5409@163.com' => 'zphui5409@163.com' }
  s.source           = { :git => '.', :tag => s.version.to_s }
  s.ios.deployment_target = '14.0'
  s.swift_versions = '5.3'
  s.source_files = 'src/**/*'
end
