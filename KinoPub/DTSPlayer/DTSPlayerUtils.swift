import UIKit

public class DTSPlayerUtils {

    ///  get current top viewController
    ///
    /// - Returns: current top viewController
    public static func activityViewController() -> UIViewController? {
        var result: UIViewController?

        guard case var window?? = UIApplication.shared.delegate?.window else {
            return nil
        }
        
        if window.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                }
            }
        }
        result = window.rootViewController
        while let presentedVC = result?.presentedViewController {
            result = presentedVC
        }
        if result is UITabBarController {
            result = (result as? UITabBarController)?.selectedViewController
        }
        while result is UINavigationController
            && (result as? UINavigationController)?.topViewController != nil {
            result = (result as? UINavigationController)?.topViewController
        }
        return result
    }

    /// get viewController from view
    ///
    /// - Parameter view: view
    /// - Returns: viewController
    public static func viewController(from view: UIView) -> UIViewController? {
        var responder = view as UIResponder
        while let nextResponder = responder.next {
            if responder is UIViewController {
                return (responder as! UIViewController)
            }
            responder = nextResponder
        }
        return nil
    }

}
