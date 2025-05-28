import UIKit

protocol SegueRouterProtocol {
    func route(with segueIdentifier: SegueIdentifier, sender: Any?)
    func prepare(viewController: SegueIdentifier, segue: UIStoryboardSegue, sender: Any?)
}

final class Router: SegueRouterProtocol {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func route(with segueIdentifier: SegueIdentifier, sender: Any?) {
        guard let sourceViewController = viewController else { return }
        sourceViewController.performSegue(withIdentifier: segueIdentifier.identifier, sender: sender)
    }

    func prepare(viewController: SegueIdentifier, segue: UIStoryboardSegue, sender: Any?) {
        switch viewController {
            case .home:
                if let homeVC = segue.destination as? UINavigationController {
                    let data = homeVC.topViewController
                    
                    guard let homeScene = data as? HomeViewController else { return }
                    // TODO: Сюда вписать данные которые передаем
                }
            case .tile:
                if let tileVC = segue.destination as? TileViewController {
                    // TODO: Сюда вписать данные которые передаем
                }
            case .quize:
                if let quizeVC = segue.destination as? QuizzMainViewController {
                    // TODO: Сюда вписать данные которые передаем
                }
        }
    }
}

enum SegueIdentifier {
    case home
    case tile
    case quize

    var identifier: String {
        switch self {
            case .home:  "HomeScene"
            case .tile:  "TileStoryBoard"
            case .quize: "Quizz"
        }
    }
}
