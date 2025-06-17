Pod::Spec.new do |s|
  s.name         = 'RNNetworkMonitor'
  s.version      = '1.0.0'
  s.summary      = 'React Native wrapper for SimpleNetworkMonitor'
  s.description  = 'Bridge para uso do SimpleNetworkMonitor no React Native.'
  s.homepage     = 'https://github.com/nicolas-magalhaes-clear/react-native-simple-network-monitor'
  s.license      = { :type => 'MIT' }
  s.author       = { 'Nicolas Magalhaes' => 'nicolas.magalhaes@clear.com.br' }
  s.platform     = :ios, '13.0'
  s.source       = { :path => '.' }
  s.source_files = 'ios/**/*.{h,m,swift}'
  s.dependency 'React-Core'
  s.dependency 'SimpleNetworkMonitor', :git => 'https://github.com/nicolas-magalhaes-clear/simple-network-monitor-pod-package.git'
end
