import UIKit

extension UILabel {
    func underlineTextStyle() {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText
            .addAttribute(
                NSAttributedString.Key.underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: textRange
            )
        // Add other attributes if needed
        self.attributedText = attributedText
    }

    func addCharactersSpacing(_ value: CGFloat = 1.15) {
        if let textString = text {
            let attrs: [NSAttributedString.Key: Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }

    func addLineHeight(min: CGFloat, max: CGFloat) {
        if let textString = text {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = min
            style.maximumLineHeight = max
            style.alignment = NSTextAlignment.center
            let attrs: [NSAttributedString.Key: Any] = [.paragraphStyle: style]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
            self.baselineAdjustment = .alignCenters
        }
    }

    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()

            style.lineSpacing = lineHeight
            attributeString
                .addAttribute(
                    NSAttributedString.Key.paragraphStyle, value: style,
                    range: NSRange(location: 0, length: text.count))
            self.attributedText = attributeString
        }
    }
}
