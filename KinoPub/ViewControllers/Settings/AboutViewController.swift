import SafariServices
import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var devNameLabel: UILabel!
    @IBOutlet weak var devInfoLabel: UILabel!

    @IBOutlet weak var designerNameLabel: UILabel!
    @IBOutlet weak var designerInfoLabel: UILabel!

    @IBOutlet weak var copyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        configView()
    }

    func configView() {
        view.backgroundColor = .kpBackground

        iconImageView.dropShadow(
            color: .kpBlack, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 6,
            scale: true)

        titleLabel.textColor = .kpOffWhite
        versionLabel.textColor = .kpGreyishBrown
        infoLabel.textColor = .kpGreyishTwo

        devNameLabel.textColor = .kpMarigold
        devInfoLabel.textColor = .kpGreyishTwo

        designerNameLabel.textColor = .kpMarigold
        designerInfoLabel.textColor = .kpGreyishTwo

        copyLabel.textColor = .kpGreyishBrown

        versionLabel.text = Config.shared.appVersion
    }

    // MARK: - Navigation

    static func storyboardInstance() -> AboutViewController? {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self))
            as? AboutViewController
    }

}
