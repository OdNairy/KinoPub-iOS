import Foundation
import UIKit
import DeviceKit

extension UIDevice {
    var wellKnownModelName: String {
        let device = DeviceKit.Device.current
        guard case let .unknown(identifier) = device else {
            return device.description
        }

        // Bases on https://gist.github.com/adamawolf/3048717
        let models: [String: String] = [
            "iPad16,1" : "iPad Mini (7th generation)",
            "iPad16,2" : "iPad Mini (7th generation)",
        ]

        return models[identifier] ?? identifier
    }
}

