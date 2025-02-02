import Alamofire
import Foundation

class BookmarksNetworkService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveBookmarks(
        completed: @escaping (_ responseArray: [Bookmarks]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveBookmarksRequest()
            .responseArray(keyPath: "items", completionHandler: completed)
    }

    func receiveBookmarkItems(
        id: String, page: String,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveBookmarkItemsRequest(id: id, page: page)
            .responseObject(completionHandler: completed)
    }

    func createBookmarkFolder(
        title: String,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.createBookmarkFolderRequest(title: title)
            .responseObject(completionHandler: completed)
    }

    func removeBookmarkFolder(
        folder: String,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.removeBookmarkFolderRequest(folder: folder)
            .responseObject(completionHandler: completed)
    }

    func removeItemFromFolder(
        item: String, folder: String,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.removeItemFromFolderRequest(item: item, folder: folder)
            .responseObject(completionHandler: completed)
    }

    func addItemToFolder(
        item: String, folder: String,
        completed: @escaping (_ responseObject: ItemResponse?, _ error: Error?) -> Void
    ) {
        requestFactory.addItemToFolderRequest(item: item, folder: folder)
            .responseObject(completionHandler: completed)
    }

    func toggleItemToFolder(
        item: String, folder: String,
        completed: @escaping (_ responseObject: BookmarksToggle?, _ error: Error?) -> Void
    ) {
        requestFactory.toggleItemToFolderRequest(item: item, folder: folder)
            .responseObject(completionHandler: completed)
    }

    func receiveItemFolders(
        item: String, completed: @escaping (_ responseArray: [Bookmarks]?, _ error: Error?) -> Void
    ) {
        requestFactory.receiveItemFoldersRequest(item: item)
            .validate()
            .responseArray(keyPath: "folders", completionHandler: completed)
    }
}
