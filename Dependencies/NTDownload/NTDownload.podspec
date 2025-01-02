
Pod::Spec.new do |s|
  s.name         = "NTDownload"
  s.version      = "1.1.0"
  s.summary      = "A lightweight Swift 4 library for download files"

  s.homepage     = "https://github.com/ntian2/NTDownload"

  s.license      = "MIT"

  s.author             = { "ntian2" => "n1179953947@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ntian2/NTDownload.git", :tag => s.version }

  s.source_files  = "NTDownload", "NTDownload/download/NTDownload/*.swift"
end
