import UIKit

class SafariActivity: UIActivity {
    var url: URL?

    public override var activityImage: UIImage? {
        return UIImage(named: "SafariActivity")!
    }

    public override var activityTitle: String? {
        return "Открыть в Safari"
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if let url = item as? URL, UIApplication.shared.canOpenURL(url) {
                return true
            }
        }
        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let url = item as? URL, UIApplication.shared.canOpenURL(url) {
                self.url = url
            }
        }
    }

    override func perform() {
        if let url = url {
            UIApplication.shared.open(url, completionHandler: activityDidFinish)
        } else {
            activityDidFinish(false)
        }

    }
}
