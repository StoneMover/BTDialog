Pod::Spec.new do |s|
  s.name             = "BTDialog"
  s.version          = "0.0.3"
  s.summary          = "An easy Dialog View"
  s.homepage         = "https://github.com/StoneMover/BTDialog"
  s.license          = 'MIT'
  s.author           = {"StoneMover" => "stonemover@163.com"}
  s.platform         = :ios, '9.0'
  s.source           = {:git => "https://github.com/StoneMover/BTDialog.git", :tag => s.version }
  s.source_files     = 'BTDialog/**/*.{h,m}'
  s.resource = 'Assets/BTDialogBundle.bundle'
  s.requires_arc     = true
  s.dependency 'BTHelp'
end