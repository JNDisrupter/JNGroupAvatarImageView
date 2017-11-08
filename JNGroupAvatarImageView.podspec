Pod::Spec.new do |s|
  s.name         = "JNGroupAvatarImageView"
  s.version      = "1.0.1"
  s.summary      = "Group avatar image view with initials"
  s.description  = "This library provide a way to create group avatar images with initials"
  s.homepage     = "https://github.com/JNDisrupter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Jayel Zaghmoutt" => "eng.jayel.z@gmail.com", "Mohammad Nabulsi" => "mohammad.s.nabulsi@gmail.com" }
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/JNDisrupter/JNGroupAvatarImageView.git", :tag => "#{s.version}"}
  s.source_files = "JNGroupAvatarImageView/**/*.{swift}"
  s.framework  = "UIKit"
  s.dependency 'JNAvatarWithInitials'
end
