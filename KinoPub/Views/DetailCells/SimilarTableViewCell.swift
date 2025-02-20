import UIKit

class SimilarTableViewCell: UITableViewCell {

    var model: VideoItemModel!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        configCollectionView()
    }

    func configView() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        titleLabel.textColor = .kpGreyishBrown
    }

    func configCollectionView() {
        collectionView.register(
            UINib(nibName: String(describing: ItemCollectionViewCell.self), bundle: Bundle.main),
            forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
        collectionView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tap)))
    }

    func config(withModel model: VideoItemModel) {
        self.model = model
    }

    @objc func tap(sender: UITapGestureRecognizer) {
        if let indexPath = self.collectionView?.indexPathForItem(
            at: sender.location(in: self.collectionView)) {
            if let cell = collectionView?.cellForItem(at: indexPath) as? ItemCollectionViewCell {
                if let image = cell.posterImageView.image {
                    showDetailVC(with: model.similarItems[indexPath.row], andImage: image)
                }
            }
        }
    }

    func showDetailVC(with item: Item, andImage image: UIImage) {
        if let detailViewController = DetailViewController.storyboardInstance() {
            detailViewController.image = image
            detailViewController.model.item = item
            parentViewController?.navigationController?.pushViewController(
                detailViewController, animated: true)
        }
    }
}

extension SimilarTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
        return model.similarItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ItemCollectionViewCell.self), for: indexPath
            ) as! ItemCollectionViewCell
        cell.set(item: model.similarItems[indexPath.row])
        return cell
    }
}

extension SimilarTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return collectionView.itemSizeToFitWidth()
    }

    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 0
    }

}
