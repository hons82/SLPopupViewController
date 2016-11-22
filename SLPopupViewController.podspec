Pod::Spec.new do |s|
  s.name           = "SLPopupViewController"
  s.version        = "1.0.0"
  s.summary        = "This library is used for showing popupViewController."
  s.description    = <<-DESC
This library is used for showing popupViewController. Compatible with swift 2.0, iOS 9
SLPopupViewController A UIViewController Category to display a ViewController as a popup with different transition effects. Written by Nguyen Duc Hoang, September 2015.
            DESC
  s.homepage       = "https://github.com/sunlight3d/SLPopupViewController"
  s.license        = { :type => "Apache 2.0", :file => "LICENSE.md" }
  s.author         = { "Nguyen Duc Hoang" => "sunlight3d@icloud.com" }
  s.platform       = :ios, "8.0"
  s.source         = { :git => "https://github.com/sunlight3d/SLPopupViewController.git", :tag => "#{s.version}" }
  s.source_files   = "SLPopupViewController/*.swift"
  s.framework      = "QuartzCore"
  s.requires_arc   = true
end
