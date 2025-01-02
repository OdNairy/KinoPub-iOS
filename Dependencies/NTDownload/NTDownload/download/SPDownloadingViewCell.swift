//
//  SPDownloadingViewCell.swift
//  download
//
//  Created by ntian on 2017/5/15.
//  Copyright © 2017年 ntian. All rights reserved.
//

import UIKit

class SPDownloadingViewCell: UITableViewCell {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var fileName: UILabel!
    var fileInfo: NTDownloadTask? {
        didSet {
            fileName.text = fileInfo?.fileName
            progressView.progress = (fileInfo?.progress)!
            guard let downloadedFileSize = fileInfo?.downloadedFileSize, let fileSize = fileInfo?.fileSize else {
                return
            }
            let progressText = String(format: "%.2f%@ / %.2f%@", downloadedFileSize.size, downloadedFileSize.unit, fileSize.size, fileSize.unit)
            progressLabel.text = progressText
        }
    }
}
