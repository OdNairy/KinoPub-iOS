import UIKit

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var bookmarkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        configView()
    }

    func configView() {
        titleLabel.textColor = .kpOffWhite
        countLabel.textColor = .kpGreyishTwo
        bookmarkImageView.image = bookmarkImageView.image?.withRenderingMode(.alwaysTemplate)
        bookmarkImageView.tintColor = .kpGreyishBrown
    }

    func config(withBookmark bookmark: Bookmarks) {
        titleLabel.text = bookmark.title
        countLabel.text = bookmark.count

    }

}
