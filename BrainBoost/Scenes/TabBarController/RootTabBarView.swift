import UIKit

final class RootTabBarView: UIImageView {

    var isActive: Bool = false {
        willSet {
            image = !newValue ? tabItem.image : tabItem.selectedImage
            tintColor = !newValue ? .blueLight : .purpleNormal

            let transform = newValue
            ? CGAffineTransform(scaleX: 1.05, y: 1.05)
            : CGAffineTransform.identity

            animatingView(transform: transform)
        }
    }

    var onTap: ((RootTabBarView) -> Void)?
    var tabItem: RootTabBarItem

    init(item: RootTabBarItem) {
        self.tabItem = item
        super.init(frame: .zero)

        configure(item: item)
        setupGesture()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(item: RootTabBarItem) {
        contentMode = .scaleAspectFit
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        image = item.image

        frame.size.height = 25
        frame.size.width = 25
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToTab))
        addGestureRecognizer(tapGesture)
    }

    private func animatingView(transform: CGAffineTransform) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5) {
                self.transform = transform
            }
    }

    @objc private func tapToTab() {
        onTap?(self)
    }
}
