import UIKit

extension UIColor {

    public class var kpBackground: UIColor {
        //        return UIColor(red: 0.102, green: 0.114, blue: 0.149, alpha: 1.00)
        return kpBlack
    }

    public class var kpLightGreen: UIColor {
        UIColor(resource: .kpLightGreen)
    }

    @nonobjc class var kpWhite: UIColor {
        UIColor(resource: .kpWhite)
    }

    @nonobjc class var kpWhiteTwo: UIColor {
        UIColor(resource: .kpWhiteTwo)
    }

    @nonobjc class var kpTangerine: UIColor {
        UIColor(resource: .kpTangerine)
    }

    @nonobjc class var kpBlack: UIColor {
        UIColor(resource: .kpBlack)
    }

    @nonobjc class var kpGreyishBrownTwo: UIColor {
        UIColor(resource: .kpGreyishBrownTwo)
    }

    @nonobjc class var kpMarigold: UIColor {
        UIColor(resource: .kpMarigold)
    }

    @nonobjc class var kpGreyish: UIColor {
        UIColor(resource: .kpGreyish)
    }

    @nonobjc class var kpOffWhite: UIColor {
        UIColor(resource: .kpOffWhite)
    }

    @nonobjc class var kpLemonGreen: UIColor {
        UIColor(resource: .kpLemonGreen)
    }

    @nonobjc class var kpGreyishTwo: UIColor {
        UIColor(resource: .kpGreyishTwo)
    }

    @nonobjc class var kpGreyishBrown: UIColor {
        UIColor(resource: .kpGreyishBrown)
    }

    @nonobjc class var kpWhite10: UIColor {
        UIColor(resource: .kpWhite10)
    }

    @nonobjc class var kpBlackTwo: UIColor {
        UIColor(resource: .kpBlackTwo)
    }

    @nonobjc class var kpBlack30: UIColor {
        UIColor(resource: .kpBlack30)
    }

    @nonobjc class var kpOffWhiteSeparator: UIColor {
        UIColor(resource: .kpOffWhiteSeparator)
    }

    @nonobjc class var kpBlackForTable: UIColor {
        UIColor(resource: .kpBlackForTable)
    }

    func isLight() -> Bool {
        let components = cgColor.components
        if let components = components {
            let brightness =
                ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
            return brightness > 0.5
        }
        return false
    }

    static func averageColor(fromImage image: UIImage?) -> UIColor {
        if let originalImage = image, let cgImage = originalImage.cgImage {
            var bitmap = [UInt8](repeating: 0, count: 4)

            let context = CIContext(options: nil)
            let cgImg = context.createCGImage(
                CoreImage.CIImage(cgImage: cgImage),
                from: CoreImage.CIImage(cgImage: cgImage).extent)

            let inputImage = CIImage(cgImage: cgImg!)
            let extent = inputImage.extent
            let inputExtent = CIVector(
                x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
            let filter = CIFilter(
                name: "CIAreaAverage",
                parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent]
            )!
            let outputImage = filter.outputImage!
            let outputExtent = outputImage.extent
            assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)

            // Render to bitmap.
            context
                .render(
                    outputImage,
                    toBitmap: &bitmap,
                    rowBytes: 4,
                    bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                    format: CIFormat.RGBA8,
                    colorSpace: CGColorSpaceCreateDeviceRGB()
                )

            // Compute result.
            let result = UIColor(
                red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0,
                blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)

            if result == UIColor(red: 0, green: 0, blue: 0, alpha: 0) {
                return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            } else {
                return result
            }
        }
        return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
}
