Pod::Spec.new do |s|
  s.name             = "BTWidgetView"
  s.version          = "0.0.8"
  s.summary          = "An easy widgetView"
  s.homepage         = "https://github.com/StoneMover/BTWidgetView"
  s.license          = 'MIT'
  s.author           = {"StoneMover" => "stonemover@163.com"}
  s.platform         = :ios, '9.0'
  s.source           = {:git => "https://github.com/StoneMover/BTWidgetView.git", :tag => s.version }
  s.source_files     = 'BTWidgetView/**/*.{h,m}'
  s.resource = 'Assets/BTDialogBundle.bundle'
  s.requires_arc     = true
  s.dependency 'BTHelp'
end