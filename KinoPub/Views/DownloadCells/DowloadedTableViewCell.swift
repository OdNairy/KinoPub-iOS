import AlamofireImage
import NTDownload
import UIKit

class DowloadedTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DowloadedTableViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var enNameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!

    var fileInfo: NTDownloadTask? {
        didSet {
            let title = fileInfo?.fileName.replacingOccurrences(of: ".mp4", with: "").components(
                separatedBy: "; ")
            nameLabel.text = title?[0]
            if title!.count > 1, title!.count > 2 {
                enNameLabel.text = title?[1]
                enNameLabel.isHidden = false
                let info = title![2].components(separatedBy: ".")
                if info.count > 1 {
                    seasonLabel.text = info[0]
                    seasonLabel.isHidden = false
                    qualityLabel.text = "  " + info[1] + "  "
                    qualityLabel.isHidden = false
                } else {
                    qualityLabel.text = "  " + info[0] + "  "
                    qualityLabel.isHidden = false
                }
            } else if title!.count > 1, title!.count < 3 {
                let info = title![1].components(separatedBy: ".")
                if info.count > 1 {
                    seasonLabel.text = info[0]
                    seasonLabel.isHidden = false
                    qualityLabel.text = "  " + info[1] + "  "
                    qualityLabel.isHidden = false
                } else {
                    qualityLabel.text = "  " + info[0] + "  "
                    qualityLabel.isHidden = false
                }
            }

            posterImageView.af.setImage(
                withURL: URL(string: (fileInfo?.fileImage)!)!,
                placeholderImage: UIImage(named: "poster-placeholder.png"),
                imageTransition: .crossDissolve(0.2),
                runImageTransitionIfCached: false)
            //            fileInfo?.delegate = self
            guard let fileSize = fileInfo?.fileSize else {
                return
            }
            let size = fileSize.unit == "GB" ? "%.2f" : "%.0f"
            progressLabel.text = String(format: "  \(size) %@  ", fileSize.size, fileSize.unit)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    func configView() {
        enNameLabel.isHidden = true
        seasonLabel.isHidden = true
        qualityLabel.isHidden = true

        backgroundColor = .clear
        nameLabel.textColor = .kpOffWhite
        enNameLabel.textColor = .kpGreyishBrown
        seasonLabel.textColor = .kpGreyishTwo

        qualityLabel.textColor = .kpBlack
        qualityLabel.backgroundColor = .kpGreyishTwo

        progressLabel.textColor = .kpBlack
        progressLabel.backgroundColor = .kpGreyishTwo
        progressLabel.text = ""
    }
}
