import UIKit

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageForQuestion: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    let zxc = ["Armenia", "Australia", "Austria", "Bhutan", "Belgium", "Czech Republic", "Kazakhstan", "Liberia", "Monaco", "Poland", "Romania", "Russia", "South Ossetia", "Switzerland", "Ukraine", "United States", "Vatican City"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient()
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        progressView.layer.borderWidth = 0.88
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.progress = 1
        imageForQuestion.layer.borderWidth = 1
        imageForQuestion.layer.borderColor = UIColor(red: 0.46, green: 0.28, blue: 1, alpha: 1).cgColor
        firstButton.layer.borderWidth = 0.88
        firstButton.layer.borderColor = UIColor.white.cgColor
        secondButton.layer.borderWidth = 0.88
        secondButton.layer.borderColor = UIColor.white.cgColor
        thirdButton.layer.borderWidth = 0.88
        thirdButton.layer.borderColor = UIColor.white.cgColor
    }
    

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        imageForQuestion.image = UIImage(named: zxc.randomElement() ?? "")
    }
    
    

}
