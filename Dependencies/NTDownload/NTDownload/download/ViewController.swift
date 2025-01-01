//
//  ViewController.swift
//  download
//
//  Created by ntian on 2017/5/1.
//  Copyright © 2017年 ntian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var downloadedTableView = UITableView()
    var downloadingTableView = UITableView()
    var downloaded = [NTDownloadTask]()
    var downloading = [NTDownloadTask]()
    
    private let downloadingCellId = "downloadingCellId"
    private let downloadedCellId = "downloadedCellId"
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func control() {
        if segmentedControl.selectedSegmentIndex == 0 {
            downloadedTableView.isHidden = false
            downloadingTableView.isHidden = true
        } else {
            downloadedTableView.isHidden = true
            downloadingTableView.isHidden = false
        }
        initdata()
    }
    @IBAction func addBtn() {
        let alert = UIAlertController(title: "URL", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "URL"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        let okAction = UIAlertAction(title: "Download", style: .default) { (action) in
            let textFiled = alert.textFields?[0].text
            let name = alert.textFields?[1].text
            NTDownloadManager.shared.addDownloadTask(urlString: textFiled!, fileName: name, fileImage: nil)
            self.initdata()
        }
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initdata()
    }
    func initdata() {

        self.downloaded = NTDownloadManager.shared.finishedList
        self.downloading = NTDownloadManager.shared.unFinishedList
        downloadedTableView.reloadData()
        downloadingTableView.reloadData()
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return downloaded.count
        } else {
            return downloading.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: downloadedCellId, for: indexPath) as! SPDownloadedViewCell
            
            cell.fileName.text = downloaded[indexPath.row].fileName
            let sizeText = "\(Int((downloaded[indexPath.row].fileSize?.size ?? 0))) \(downloaded[indexPath.row].fileSize?.unit ?? "")"
            cell.fileSize.text = sizeText
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: downloadingCellId, for: indexPath) as! SPDownloadingViewCell
            cell.fileInfo = downloading[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag != 1 {
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SPDownloadingViewCell
        if cell.fileInfo?.status == .NTDownloading {
            NTDownloadManager.shared.pauseTask(downloadTask: cell.fileInfo!)
        } else if cell.fileInfo?.status == .NTPauseDownload {
            NTDownloadManager.shared.resumeTask(downloadTask: cell.fileInfo!)
        }
    }
}

// MARK: - NTDownloadManagerDelegate
extension ViewController: NTDownloadManagerDelegate {
    func downloadRequestFinished(downloadTask: NTDownloadTask) {
        print("DownloadFinished \(downloadTask.fileName)")
        initdata()
    }
    func downloadRequestUpdateProgress(downloadTask: NTDownloadTask) {
        let cellArr = self.downloadingTableView.visibleCells
        for obj in cellArr {
            if obj.isKind(of: SPDownloadingViewCell.self) {
                let cell = obj as! SPDownloadingViewCell
                if cell.fileInfo?.fileURL == downloadTask.fileURL {
                    cell.fileInfo = downloadTask
                }
            }
        }
    }
    func downloadRequestDidStarted(downloadTask: NTDownloadTask) {
        print("Start")
    }
    func downloadRequestDidPaused(downloadTask: NTDownloadTask) {
        print("Pause")
    }
}
extension ViewController {
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        let rect = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        NTDownloadManager.shared.delegate = self
        downloadedTableView = UITableView(frame: rect, style: .plain)
        downloadingTableView = UITableView(frame: rect, style: .plain)
        view.addSubview(downloadedTableView)
        view.addSubview(downloadingTableView)
        downloadedTableView.tag = 0
        downloadedTableView.isHidden = false
        downloadedTableView.dataSource = self
        downloadedTableView.delegate = self
        downloadedTableView.register(UINib(nibName: "SPDownloadedViewCell", bundle: nil), forCellReuseIdentifier: downloadedCellId)
        downloadedTableView.rowHeight = 50
        downloadingTableView.tag = 1
        downloadingTableView.dataSource = self
        downloadingTableView.delegate = self
        downloadingTableView.isHidden = true
        downloadingTableView.register(UINib(nibName: "SPDownloadingViewCell", bundle: nil), forCellReuseIdentifier: downloadingCellId)
        downloadingTableView.rowHeight = 50
    }
}
