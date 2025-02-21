import CustomLoader
import LKAlertController
import UIKit

class ButtonsTableViewCell: UITableViewCell {
    private let logViewsManager = Container.Manager.logViews
    var model: VideoItemModel!
    var bookmarksModel: BookmarksModel!

    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var watchlistAndDownloadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    func configView() {
        bookmarkButton.setTitleColor(.kpGreyishTwo, for: .normal)
        watchlistAndDownloadButton.setTitleColor(.kpGreyishTwo, for: .normal)
        bookmarkButton.layerBorderColor = .kpGreyishBrown
        watchlistAndDownloadButton.layerBorderColor = .kpGreyishBrown
    }

    func config(withModel model: VideoItemModel, bookmarksModel: BookmarksModel) {
        self.model = model
        self.bookmarksModel = bookmarksModel
        configBookmarksButton()
        configWatchlistAndDownloadButton()
    }

    func configBookmarksButton() {
        if let _itemFolders = model.item.bookmarks, _itemFolders.count > 0 {
            bookmarkButton.setImage(UIImage(named: "Ok"), for: .normal)
            bookmarkButton.setTitle(_itemFolders[0].title, for: .normal)
            bookmarkButton.layerBorderColor = .kpMarigold
        } else {
            bookmarkButton.setImage(nil, for: .normal)
            bookmarkButton.setTitle("В закладки", for: .normal)
            bookmarkButton.layerBorderColor = .kpGreyishBrown
        }
        bookmarkButton.addTarget(self, action: #selector(showBookmarkFolders), for: .touchUpInside)
    }

    func configWatchlistAndDownloadButton() {
        if model.item.type == ItemType.shows.rawValue
            || model.item.type == ItemType.docuserial.rawValue
            || model.item.type == ItemType.tvshows.rawValue {
            watchlistAndDownloadButton.addTarget(
                self, action: #selector(changeWatchlist), for: .touchUpInside)
            if model.item.inWatchlist == true {
                watchlistAndDownloadButton.setImage(UIImage(named: "Ok"), for: .normal)
                watchlistAndDownloadButton.setTitle("Смотрю", for: .normal)
                watchlistAndDownloadButton.layerBorderColor = .kpMarigold
            } else {
                watchlistAndDownloadButton.setImage(nil, for: .normal)
                watchlistAndDownloadButton.setTitle("Буду смотреть", for: .normal)
                watchlistAndDownloadButton.layerBorderColor = .kpGreyishBrown
            }
        } else {
            watchlistAndDownloadButton.addTarget(
                self, action: #selector(showWatchAction), for: .touchUpInside)
            if model.item.videos?.first?.watched == 0 {
                watchlistAndDownloadButton.setTitle("Смотрю", for: .normal)
                watchlistAndDownloadButton.layerBorderColor = .kpMarigold
            } else {
                watchlistAndDownloadButton.setTitle("Буду смотреть", for: .normal)
                watchlistAndDownloadButton.layerBorderColor = .kpGreyishBrown
            }
        }
    }

    @objc func changeWatchlist() {
        logViewsManager.changeWatchlist(id: model.item.id?.string ?? "")
    }

    @objc func showBookmarkFolders() {
        _ = LoadingView.system(withStyle: .medium).show(inView: bookmarkButton)
        bookmarksModel.loadBookmarks { [weak self] (bookmarks) in
            guard let strongSelf = self else { return }
            let action = ActionSheet(message: "Выберите папку").tint(.kpBlack)

            for folder in bookmarks! {
                var folderTitle = folder.title
                var style: UIAlertAction.Style = .default
                for itemFolder in strongSelf.model.item.bookmarks! {
                    if itemFolder.title == folder.title {
                        folderTitle = "✓ " + folderTitle
                        style = .destructive
                    }
                }
                action.addAction(
                    folderTitle, style: style,
                    handler: { (_) in
                        strongSelf.bookmarksModel.toggleItemToFolder(
                            item: String((strongSelf.model.item.id)!), folder: String(folder.id))
                    })
            }
            action.addAction("Отмена", style: .cancel)
            action.setPresentingSource(strongSelf.bookmarkButton)
            action.show()
            Helper.hapticGenerate(style: .medium)
            strongSelf.bookmarkButton.removeLoadingViews(animated: true)
        }
    }

    @objc func showWatchAction() {
        guard let watch = model.item?.videos?.first?.watching.status else { return }
        let actionVC = ActionSheet().tint(.kpBlack)

        actionVC.addAction(
            watch == Status.watching ? "Удалить из «Я смотрю»" : "Добавить в «Я смотрю»",
            style: .default
        ) { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.logViewsManager.changeWatchlistForMovie(
                id: strongSelf.model.item?.id ?? 0, time: watch == Status.watching ? 0 : 30)
        }
        actionVC.addAction(
            watch == Status.watched ? "Еще не смотрел" : "Уже видел", style: .default
        ) { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.logViewsManager.changeWatchingStatus(
                id: strongSelf.model.item?.id ?? 0, video: nil, season: 0, status: nil)
        }
        actionVC.addAction("Отмена", style: .cancel)
        actionVC.setPresentingSource(watchlistAndDownloadButton)
        actionVC.show()
        Helper.hapticGenerate(style: .medium)
    }

    @objc func showQualitySelectAction() {
        let actionVC = ActionSheet(message: "Выберите качество").tint(.kpBlack)

        guard let files = model.files else { return }
        for file in files {
            actionVC.addAction(
                file.quality!, style: .default,
                handler: { [weak self] (_) in
                    guard let strongSelf = self else { return }
                    strongSelf.showDownloadAction(
                        with: (file.url?.http)!, quality: file.quality!,
                        inView: strongSelf.watchlistAndDownloadButton)
                })
        }
        actionVC.addAction("Отменить", style: .cancel)
        actionVC.setPresentingSource(watchlistAndDownloadButton)
        actionVC.show()
        Helper.hapticGenerate(style: .medium)
    }

    func showDownloadAction(with url: String, quality: String, inView view: UIView) {
        let name =
            (self.model.item?.title?.replacingOccurrences(of: " /", with: ";"))!
            + "; \(quality).mp4"
        let poster = self.model.item?.posters?.small
        Share().showActions(url: url, title: name, quality: quality, poster: poster!, inView: view)
    }

}
