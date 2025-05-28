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

//  Для использования добавить в контроллер:
//  lazy var router: SegueRouterProtocol = SegueRouter(source: self)
//  В экшене прописать func route(with segueIdentifier: .home, sender: self)

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

// Если создали новый экран, добавляете новый кейс и его идентификатор
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
