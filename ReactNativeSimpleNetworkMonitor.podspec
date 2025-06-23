require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = 'ReactNativeSimpleNetworkMonitor'
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.authors      = package['author']

  s.platforms    = { ios: min_ios_version_supported }
  s.source       = { git: 'https://github.com/nicolas-magalhaes-clear/react-native-simple-network-monitor.git', tag: "#{s.version}" }

  s.source_files = 'ios/**/*.{h,m,mm,cpp,swift}'
  s.private_header_files = 'ios/**/*.h'
  s.dependency 'SimpleNetworkMonitor'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '5.0',
    'DEFINES_MODULE' => 'YES'
  }

  install_modules_dependencies(s)
end
