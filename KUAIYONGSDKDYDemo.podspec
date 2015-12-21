Pod::Spec.new do |s|
  s.name         = "KUAIYONGSDKDYDemo"
  s.version      = "0.0.3"
  s.summary      = "Demo for Quiuk uniform Platform"
  s.description  = <<-DESC
                  You can download this one for test when you are developping on KUAIYONGSDK.
                   DESC
  s.homepage     = "https://github.com/tanglimei/KUAIYONGSDKDYDemo.git"
  s.author             = { "tanglimei" => "562630424@qq.com" }
  s.license      = "MIT"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/tanglimei/KUAIYONGSDKDYDemo.git", :tag => "0.0.3" }
  s.source_files  = "Common/Source/Demo/QUPAppDelegate.{h,m}","Common/Source/Demo/QUPViewController.{h,m}","Common/SDK/Platform/KUAIYONGSDK/DYFramework/QuickUnifyPlatform.framework/Headers/*.h"
  s.public_header_files = "Common/SDK/Platform/KUAIYONGSDK/DYFramework/QuickUnifyPlatform.framework/Headers/*.h"
  s.resources = ["Common/SDK/Platform/KUAIYONGSDK/SDKSource/SDKFinal/*.bundle","Common/SDK/Platform/KUAIYONGSDK/Plist/*.plist","DYSDK/KUAIYONGSDK/QuickUnifyPlatformDemo/QuickUnifyPlatformDemo/QUPInfo.plist"]
  s.ios.vendored_frameworks = "Common/SDK/Platform/KUAIYONGSDK/DYFramework/QuickUnifyPlatform.framework","Common/SDK/Platform/KUAIYONGSDK/SDKSource/SDKFinal/*.framework"
  s.requires_arc = true
  s.xcconfig = { 
    "OTHER_LDFLAGS" => "-ObjC",
    "ENABLE_BITCODE" => "NO"
     }
end
