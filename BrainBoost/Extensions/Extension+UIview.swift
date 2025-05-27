import UIKit

extension UIView {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addGradient() {
        addVerticalGradientLayer(
            topColor: UIColor(
                red: 0.624,
                green: 0.498,
                blue: 1,
                alpha: 1
            ),
            bottomColor: UIColor(
                red: 0.502,
                green: 0.333,
                blue: 0.996,
                alpha: 1
            )
        )
    }
}
