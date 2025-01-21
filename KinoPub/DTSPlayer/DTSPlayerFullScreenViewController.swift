import AVKit
import UIKit

class DTSPlayerFullScreenViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.allowsPictureInPicturePlayback = true
        self.delegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.post(
            name: .DTSPlayerViewControllerDismissed, object: self, userInfo: nil)
    }

}

extension DTSPlayerFullScreenViewController: AVPlayerViewControllerDelegate {
    func playerViewController(
        _ playerViewController: AVPlayerViewController,
        restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler:
            @escaping (Bool) -> Void
    ) {
        guard let activityViewController = DTSPlayerUtils.activityViewController() else { return }
        activityViewController.present(playerViewController, animated: true) {
            completionHandler(true)
        }
    }
}
