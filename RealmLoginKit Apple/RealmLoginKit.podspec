Pod::Spec.new do |s|
  s.name     = 'RealmLoginKit'
  s.version  = '0.0.9'
  s.license  =  { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.summary  = 'A generic login view controller for apps that use the Realm Mobile Platform'
  s.homepage = 'https://realm.io'
  s.author   = { 'Realm' => 'help@realm.io' }
  s.source   = { :git => 'https://github.com/realm-demos/realm-loginkit.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.platform = :ios, '9.0'
  s.source_files = 'RealmLoginKit Apple/RealmLoginKit/**/*.{swift}'
  s.dependency 'Realm'
  s.dependency 'TORoundedTableView'
end