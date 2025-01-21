import FirebaseRemoteConfig
import SwiftyUserDefaults
import UIKit

protocol ConfigDelegate: AnyObject {
    func configDidLoad()
}

class Config {
    static let shared = Config()
    //    var remoteConfig: RemoteConfig!
    weak var delegate: ConfigDelegate?
    let hiddenMenusService: HiddenMenusService

    let defaultValues = [
        "kinopubClientId": Defaults[.kinopubClientId] as NSObject,
        "kinopubClientSecret": Defaults[.kinopubClientSecret] as NSObject,
        "delayViewMarkTime": Defaults[.delayViewMarkTime] as NSObject,
        "kinopubDomain": Defaults[.kinopubDomain] as NSObject
    ]

    var appVersion: String {
        if let dictionary = Bundle.main.infoDictionary {
            let version = dictionary["CFBundleShortVersionString"] as! String
            let build = dictionary["CFBundleVersion"] as! String
            return "Версия \(version), билд \(build)"
        }
        return ""
    }

    var kinopubClientId: String {
        Config.kinopub.clientId
        //        return remoteConfig["kinopubClientId"].stringValue //?? kinopub.clientId
    }

    var kinopubClientSecret: String {
        Config.kinopub.clientSecret
        //        return remoteConfig["kinopubClientSecret"].stringValue// ?? kinopub.clientSecret
    }

    var delayViewMarkTime: TimeInterval {
        180
        //        return remoteConfig["delayViewMarkTime"].numberValue as? TimeInterval ?? /*180*/
    }

    var kinopubDomain: String {
        Config.kinopub.domain
        //        return remoteConfig["kinopubDomain"].stringValue //?? kinopub.domain
    }

    var clientTitle: String {
        return Defaults[.clientTitle]
    }

    var menuItem: Int {
        return Defaults[.menuItem]
    }

    var streamType: String {
        return Defaults[.streamType]
    }

    var logViews: Bool {
        return Defaults[.logViews]
    }

    var canSortSeasons: Bool {
        return Defaults[.canSortSeasons]
    }

    var canSortEpisodes: Bool {
        return Defaults[.canSortEpisodes]
    }

    var menuVisibleContentWidth: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 1.6 : 5
    }

    init() {
        hiddenMenusService = HiddenMenusService()
        //        remoteConfig = RemoteConfig.remoteConfig()
        //        remoteConfig.setDefaults(defaultValues)
        //        fetchRemoteConfig()
    }

    //    func fetchRemoteConfig() {
    // #if DEBUG
    //        // FIXME: Remove before production!
    //        let remoteConfigSettings = RemoteConfigSettings()
    //        remoteConfigSettings.minimumFetchInterval = 0
    //        remoteConfig.configSettings = remoteConfigSettings
    // #endif
    //
    //        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
    //            guard error == nil else {
    //                print("Error fetch remote config: \(error?.localizedDescription ?? "unknown")")
    //                return
    //            }
    //            self.writeInUserDefaults()
    //            self.remoteConfig.activate()
    //            self.delegate?.configDidLoad()
    //        }
    //    }
    //
    //    func writeInUserDefaults() {
    //        Defaults[.kinopubClientId] = remoteConfig["kinopubClientId"].stringValue
    //        Defaults[.kinopubClientSecret] = remoteConfig["kinopubClientSecret"].stringValue
    //        Defaults[.delayViewMarkTime] = remoteConfig["delayViewMarkTime"].numberValue as! TimeInterval
    //        Defaults[.kinopubDomain] = remoteConfig["kinopubDomain"].stringValue
    //    }
    //
}
