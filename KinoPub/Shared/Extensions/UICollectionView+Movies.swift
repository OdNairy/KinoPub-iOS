import UIKit

extension UICollectionView {
    func numberOfItemsToFitWidth() -> Int {
        guard let orientation = window?.windowScene?.interfaceOrientation else { return 2 }

        switch (orientation, UIDevice.current.userInterfaceIdiom) {
        case (.landscapeLeft, .pad), (.landscapeRight, .pad):
            return 6
        case (.portrait, .pad), (.portraitUpsideDown, .pad):
            return 4
        case (.landscapeLeft, _), (.landscapeRight, _):
            return 4
        default:
            return 2
        }
    }

    func itemSizeToFitWidth() -> CGSize {
        let constant = CGFloat(numberOfItemsToFitWidth())
        let availableWidth = bounds.width - (contentInset.left + contentInset.right)
        let itemWidth = availableWidth / constant
        let height = itemWidth * 1.569
        return CGSize(width: itemWidth, height: height)
    }
}
