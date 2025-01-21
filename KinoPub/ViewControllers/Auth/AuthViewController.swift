import CustomLoader
import UIKit

class AuthViewController: UIViewController {
    fileprivate let viewModel = Container.ViewModel.auth()

    let pasteboard = UIPasteboard.general

    //    @IBOutlet weak var URLLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTitleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var activateButton: UIButton!

    @IBAction func activateButtonTapped(_ sender: Any) {
        openSafariVC()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        viewModel.delegate = self
        Config.shared.delegate = self
        config()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.invalidateTimer()
    }

    func config() {
        view.backgroundColor = .kpBackground
        titleLabel.textColor = .kpOffWhite
        descLabel.textColor = .kpGreyishTwo
        codeLabel.textColor = .kpOffWhite
        codeTitleLabel.textColor = .kpGreyishBrown
        activateButton.backgroundColor = .kpMarigold
        activateButton.setTitleColor(.kpBlack, for: .normal)
        activateButton.setTitle("", for: .disabled)

        loadCode()
        //        if Config.shared.kinopubDomain == "" {
        codeLabel.text = "загрузка"
        activateButton.isEnabled = false
        _ = LoadingView.system(withStyle: .medium).show(inView: activateButton)
        //            URLLabel.text = "загрузка..."
        //        } else {
        //            URLLabel.text = "\(Config.shared.kinopubDomain)/device"
        //            let tapURLLabel = UITapGestureRecognizer(target: self, action: #selector(openSafariVC(_:)))
        //            URLLabel.isUserInteractionEnabled = true
        //            URLLabel.addGestureRecognizer(tapURLLabel)
        //            activateButton.isEnabled = true
        //        }
    }

    func configButton() {
        activateButton.removeLoadingViews(animated: true)
        activateButton.isEnabled = true
    }

    func loadCode() {
        viewModel.loadDeviceCode { [weak self] (authResponse) in
            guard let strongSelf = self else { return }
            strongSelf.codeLabel.text = authResponse.userCode
            strongSelf.pasteboard.string = authResponse.userCode ?? ""
        }
    }

    func openSafariVC() {
        if let code = viewModel.userCode {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(
                    URL(string: "\(Config.shared.kinopubDomain)/device?code=\(code)")!,
                    options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(
                    URL(string: "\(Config.shared.kinopubDomain)/device?code=\(code)")!)
            }
        }
    }

    static func storyboardInstance() -> AuthViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? AuthViewController
    }

}

extension AuthViewController: ConfigDelegate {
    func configDidLoad() {
        configButton()
    }
}

extension AuthViewController: AuthModelDelegate {
    func authModelDidAuth(authModel: AuthModel) {
        self.dismiss(animated: true, completion: nil)
        authModel.invalidateTimer()
    }

    func updateCode(authModel: AuthModel) {
        loadCode()
    }
}
