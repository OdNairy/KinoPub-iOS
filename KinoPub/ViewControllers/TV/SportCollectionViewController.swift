import GradientLoadingBar
import InteractiveSideMenu
import UIKit

class SportCollectionViewController: UICollectionViewController, SideMenuItemContent {
    private let model = Container.ViewModel.tv()
    private let mediaManager = Container.Manager.media
    let gradientLoadingBar = GradientLoadingBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configTitle()
        configCollectionView()
    }

    override func viewWillTransition(
        to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }

    func config() {
        model.delegate = self
        gradientLoadingBar.show()
        model.loadSportChannels()
    }

    func configTitle() {
        title = "Спортивные каналы"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.kpOffWhite]
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
        }
    }

    func configCollectionView() {
        collectionView?.backgroundColor = .kpBackground
        collectionView?.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openChannel(_:))))
        // Register cell classes
        if let collectionView = self.collectionView {
            collectionView.contentInset = UIEdgeInsets(top: 8.0, left: 7.0, bottom: 8.0, right: 7.0)

            collectionView.register(
                UINib(nibName: String(describing: TVCollectionViewCell.self), bundle: Bundle.main),
                forCellWithReuseIdentifier: String(describing: TVCollectionViewCell.self))
        }
    }

    func updateCollectionViewLayout(with size: CGSize) {
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
    }

    // MARK: - Navigation
    @objc func openChannel(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.collectionView?.indexPathForItem(
            at: sender.location(in: self.collectionView)) {
            guard let stream = model.sportChannels[indexPath.row].stream else { return }
            guard let url = URL(string: stream) else { return }
            var mediaItem = MediaItem()
            mediaItem.url = url
            mediaItem.title = model.sportChannels[indexPath.row].title
            mediaManager.playVideo(mediaItems: [mediaItem], isLive: true)
        }
    }

    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if let navigationViewController = self.navigationController as? SideMenuItemContent {
            navigationViewController.showSideMenu()
        }
    }

}

// MARK: - UICollectionView DataSource & Delegate
extension SportCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return model.sportChannels.count
    }

    override func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: TVCollectionViewCell.self), for: indexPath)
            as! TVCollectionViewCell
        cell.config(withChannel: model.sportChannels[indexPath.row])
        return cell
    }
}

extension SportCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let windowScene = collectionView.window?.windowScene

        var constant: CGFloat

        switch (windowScene?.interfaceOrientation, UIDevice.current.userInterfaceIdiom) {
        case (.landscapeLeft, .pad), (.landscapeRight, .pad):
            constant = 6
        case (.portrait, .pad), (.portraitUpsideDown, .pad),
             (.landscapeLeft, _), (.landscapeRight, _):
            constant = 4
        default:
            constant = 2
        }

        let width =
            (collectionView.bounds.width
                - (collectionView.contentInset.left + collectionView.contentInset.right)) / constant
        let height = width * 0.796
        return CGSize(width: width, height: height)
    }
}

// MARK: - TVModel Delegate
extension SportCollectionViewController: TVModelDelegate {
    func didUpdateChannels(model: TVModel) {
        collectionView?.reloadData()
        gradientLoadingBar.hide()
    }
}
