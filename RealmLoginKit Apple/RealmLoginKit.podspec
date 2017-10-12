Pod::Spec.new do |s|
  s.name     = 'RealmLoginKit'
  s.version  = '0.1.3'
  s.license  =  { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.summary  = 'A generic login view controller for apps that use the Realm Mobile Platform'
  s.homepage = 'https://realm.io'
  s.author   = { 'Realm' => 'help@realm.io' }
  s.source   = { :git => 'https://github.com/realm-demos/realm-loginkit.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.platform = :ios, '9.0'
  s.default_subspec = 'Core'
  s.dependency 'Realm'
  s.dependency 'TORoundedTableView'

  s.subspec 'Core' do |core|
    core.source_files = '**/RealmLoginKit/**/*.{swift}'
    core.exclude_files = '**/RealmLoginKit/Models/AuthenticationProviders/*'
  end

  s.subspec 'AWSCognito' do |aws|
    aws.source_files = '**/RealmLoginKit/**/*.{swift}'
    aws.dependency 'AWSCognito'
    aws.dependency 'AWSCognitoIdentityProvider'
  end
end
