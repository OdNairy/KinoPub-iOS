import Foundation
import LKAlertController
import NotificationBannerSwift

protocol CollectionModelDelegate: AnyObject {
    func didUpdateItem(model: CollectionModel)
}

class CollectionModel {
    weak var delegate: CollectionModelDelegate?
    var collections = [Collections]()
    var page: Int = 1

    let accountManager: AccountManager
    let networkingService: CollectionsNetworkingService

    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        networkingService = CollectionsNetworkingService(
            requestFactory: accountManager.requestFactory)
        //        accountManager.addDelegate(delegate: self)
    }

    func loadCollections(completed: @escaping (_ count: Int?) -> Void) {
        networkingService.receiveCollections(page: page.string) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let itemsData = response {
                guard let items = itemsData.items else { return }
                strongSelf.page += 1
                strongSelf.collections.append(contentsOf: items)
                completed(itemsData.items?.count)
            } else {
                debugPrint("[!ERROR]: \(String(describing: error?.localizedDescription))")
                Alert(title: "Ошибка", message: error?.localizedDescription)
                    .showOkay()
                completed(nil)
            }
        }
    }

    func refresh() {
        page = 1
        collections.removeAll()
    }
}
