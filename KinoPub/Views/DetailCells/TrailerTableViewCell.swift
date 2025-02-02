import CustomLoader
import AVFoundation
import UIKit

class TrailerTableViewCell: UITableViewCell {
    var trailer: Trailer?

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

    func config(trailer: Trailer, item: Item) {
        self.trailer = trailer

        if let mediumPosterURL = item.posters?.medium.map(URL.init(string:)) ?? nil {
            thumbImageView.af.setImage(
                withURL: mediumPosterURL,
                placeholderImage: UIImage(named: "episode.png"),
                imageTransition: .crossDissolve(0.2),
                runImageTransitionIfCached: false
            )
        }

    }

    @objc func play() {
        playButtonView.alpha = 0.7
        UIView.animate(
            withDuration: 0.8,
            animations: {
                self.playButtonView.alpha = 1
            })

        if let trailer = trailer, let trailerURL = URL(string: trailer.url) {
            let playerItem = AVPlayerItem(url: trailerURL)
            MediaManager.shared.playWithNativePlayer(mediaItems: [playerItem])
            Helper.hapticGenerate(style: .medium)
        }
    }

}
