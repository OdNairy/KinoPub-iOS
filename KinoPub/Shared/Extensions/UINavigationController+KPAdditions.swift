import UIKit

extension UINavigationController {
    public func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return topViewController
    }
}
