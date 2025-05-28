import UIKit

struct Font {
    let font: UIFont
    let lineHeight: CGFloat

    func compose(_ text: String, color: UIColor? = .black) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = self.lineHeight

        attributedString.addAttributes(
            [
                NSAttributedString.Key.font : self.font,
                NSAttributedString.Key.foregroundColor : color ?? .black,
                NSAttributedString.Key.paragraphStyle : paragraphStyle,
            ],
            range: NSRange(location: 0, length: attributedString.length)
        )

        return attributedString
    }
}

extension Font {
    enum Family {
        case poppinsBold
        case poppinsRegular
        case poppinsMedium
        case poppinsSemiBold

        var title: String {
            switch self {
            case .poppinsBold:     "Poppins-Bold.ttf"
            case .poppinsRegular:  "Poppins-Regular.ttf"
            case .poppinsMedium:   "Poppins-Medium.ttf"
            case .poppinsSemiBold: "Poppins-SemiBold.ttf"
            }
        }
    }
}

extension Font {
    static let heading4 = Font(
        font: UIFont(name: Family.poppinsBold.title, size: 28)!,
        lineHeight: 0.86
    )

    static let subtitle1 = Font(
        font: UIFont(name: Family.poppinsRegular.title, size: 20)!,
        lineHeight: 0.67
    )

    static let segment1 = Font(
        font: UIFont(name: Family.poppinsMedium.title, size: 20)!,
        lineHeight: 1.07
    )

    static let segment2 = Font(
        font: UIFont(name: Family.poppinsSemiBold.title, size: 18)!,
        lineHeight: 0.89
    )

    static let button = Font(
        font: UIFont(name: Family.poppinsRegular.title, size: 20)!,
        lineHeight: 0.73
    )

    static let button2 = Font(
        font: UIFont(name: Family.poppinsRegular.title, size: 17)!,
        lineHeight: 0.86
    )

    static let description = Font(
        font: UIFont(name: Family.poppinsRegular.title, size: 16)!,
        lineHeight: 1
    )

    static let timer = Font(
        font: UIFont(name: Family.poppinsSemiBold.title, size: 15)!,
        lineHeight: 0
    )

    static let caption = Font(
        font: UIFont(name: Family.poppinsRegular.title, size: 13)!,
        lineHeight: 0.92
    )
}
