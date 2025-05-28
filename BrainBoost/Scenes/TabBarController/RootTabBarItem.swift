import UIKit

enum RootTabBarItem: CaseIterable {
    case home
    case tile
    case quize

    static func tabIndex(of item: RootTabBarItem) -> Int {
        allCases.firstIndex(of: item) ?? 0
    }

    var image: UIImage {
        switch self {
            case .home:  UIImage(resource: .home)
            case .tile:  UIImage(resource: .discover)
            case .quize: UIImage(resource: .rating)
        }
    }

    var selectedImage: UIImage {
        switch self {
            case .home:  UIImage(resource: .selectedHome)
            case .tile:  UIImage(resource: .selectedDiscover)
            case .quize: UIImage(resource: .selectedRating)
        }
    }
}
