# NTDownload

<p align="center">
<a href="https://github.com/ntian2/NTDownload/"><img src="https://img.shields.io/cocoapods/v/NTDownload.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/ntian2/NTDownload/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/NTDownload.svg?style=flat"></a>
<a href="https://github.com/ntian2/NTDownload/"><img src="https://img.shields.io/cocoapods/p/NTDownload.svg?style=flat"></a>
<a href="https://github.com/ntian2/NTDownload/"><img src="https://img.shields.io/badge/Swift-4.0%2B-orange.svg"></a>
</p>

NTDownlaod 是一个非常小的, Swift 4 写的 下载库.

## 特点
- [x] 支持断点续传.
- [x] 后台下载.
- [x] 基于 `URLSession`.
- [x] 可以随时下载或者暂停任务.
- [x] 仅有4个文件.

## 要求
* iOS 8.0+
* Swift 4

## 安装
NTDownload 支持 Cocoapods. 所以你可以将其添加到你的 Podfile 里.

```ruby
pod 'NTDownload'
```

## 实例
```swift
let urlString = "url_of_you_file"
NTDownloadManager.shared.addDownloadTask(urlString: urlString)
```
你也可以 clone repo, 然后 运行这个 实例.
## GIF Demo
![GIFDemo](https://github.com/ntian2/NTDownload/raw/master/NTDownload.gif)

## License
NTDownload is released under the MIT license. See LICENSE for details.