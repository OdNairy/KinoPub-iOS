import CustomLoader
import UIKit

class TrailerTableViewCell: UITableViewCell {

    var youtubeID: String!

    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var playButtonView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        configView()
    }

    func configView() {
        backgroundColor = .clear
        thumbView.dropShadow(
            color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2.0), radius: 6,
            scale: true)
        playButtonView.backgroundColor = .kpMarigold
        playButtonView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(play)))
    }

    func config(withId id: String) {
        youtubeID = id
        thumbImageView.af_setImage(
            withURL: URL(string: "https://img.youtube.com/vi/\(id)/maxresdefault.jpg")!,
            placeholderImage: UIImage(named: "episode.png"),
            imageTransition: .crossDissolve(0.2),
            runImageTransitionIfCached: false
        ) { [weak self] (response) in
            if response.result.isFailure {
                self?.setImage(withId: id)
            }
        }
    }

    func setImage(withId id: String) {
        thumbImageView.af_setImage(
            withURL: URL(string: "https://img.youtube.com/vi/\(id)/0.jpg")!,
            placeholderImage: UIImage(named: "episode.png"),
            imageTransition: .crossDissolve(0.2),
            runImageTransitionIfCached: false)
    }

    @objc func play() {
        playButtonView.alpha = 0.7
        UIView.animate(
            withDuration: 0.8,
            animations: {
                self.playButtonView.alpha = 1
            })
        MediaManager.shared.playYouTubeVideo(withID: youtubeID)
        Helper.hapticGenerate(style: .medium)
    }

}
