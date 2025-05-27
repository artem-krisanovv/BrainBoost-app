import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()

        tabBar.tintColor = .black
    }
}
