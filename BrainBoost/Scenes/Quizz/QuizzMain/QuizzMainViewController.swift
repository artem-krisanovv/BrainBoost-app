import UIKit

class QuizzMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
    }

    @IBAction func backToMainButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
