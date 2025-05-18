
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var difficultySegment: UISegmentedControl!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var buttonImage: [UIImageView]!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var tileButtons: [UIButton]!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var game = Model()
    var tagOfFirstButton: Int? = nil
    var timer: Timer?
    var timeLeft: Int = 30
    var stopButtonStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startUI()
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            timeLeft = 30
            timerLabel.text = "Time:    \(timeLeft) seconds"
        case 1:
            timeLeft = 20
            timerLabel.text = "Time:    \(timeLeft) seconds"
        case 2:
            timeLeft = 15
            timerLabel.text = "Time:    \(timeLeft) seconds"
        default:
            timerLabel.text = "Time:    \(timeLeft) seconds"
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopButtonStatus.toggle()
        if stopButtonStatus {
            stopButton.setTitle("Unpause", for: .normal)
            timer?.invalidate()
            allButtonActivate(bool: false)
        } else {
            stopButton.setTitle("Stop", for: .normal)
            unPauseTimer()
            for button in tileButtons {
                if buttonImage[button.tag].image == nil { // делаем доступными только те кнопки, пара которых не найдена
                    button.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startTimer()
        game.generaterTiles()
        allButtonActivate(bool: true)
        startUI()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag
        var tileImageView: UIImageView = UIImageView()
        for view in buttonImage {
            if view.tag == tag {
                tileImageView = view // как только находим карточку схожую по тегу, передаём в переменную значение верной карточки
                break
            }
        }
        guard let correctTile = game.returnTile(tag: tag), !correctTile.isChoiceMatches else { return } // ! необходим чтобы перекрыть те карточки, пара которых найдена,при true мы просто выходим
        tileImageView.image = UIImage(named: correctTile.imagesNumber)
        sender.isEnabled = false
        
        if let first = tagOfFirstButton {
            if let firstTile = game.returnTile(tag: first), firstTile.imagesNumber == correctTile.imagesNumber {
                game.markMatched(firstTag: first, secondTag: tag)
                tagOfFirstButton = nil
                pointsLabel.text = "\(game.score)"
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.hideImageView(tag: tag)
                    self.hideImageView(tag: first)
                    self.oneButtonActivate(tag: tag)
                    self.oneButtonActivate(tag: first)
                }
                tagOfFirstButton = nil
            }
        } else {
            tagOfFirstButton = tag
        }
    }
    
    func startUI() {
        view.addVerticalGradientLayer(
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
        difficultySegment.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )
        difficultySegment.setTitleTextAttributes(
            [.foregroundColor: UIColor(
                red: 0.667,
                green: 0.553,
                blue: 1,
                alpha: 1
            )],
            for: .selected
        )
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        progressView.layer.borderWidth = 0.66
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.progress = 1.0
        pointsLabel.text = "0"
        tagOfFirstButton = nil
        stopButton.setTitle("Stop", for: .normal)
        timerLabel.text = "Time:    \(timeLeft) seconds"
        game.score = 0
        for imageView in buttonImage {
            imageView.image = UIImage()
            imageView.isUserInteractionEnabled = true
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        switch difficultySegment.selectedSegmentIndex {
        case 0: timeLeft = 30
        case 1: timeLeft = 20
        case 2: timeLeft = 15
        default: timeLeft = 30
        }
        let total = timeLeft
        progressView.progress = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
            self.progressView.progress = Float(self.timeLeft) / Float(total)
            self.timerLabel.text = "Time:    \(self.timeLeft) seconds"
            
            if self.timeLeft <= 0 {
                self.timer?.invalidate()
                self.showEndAlert()
                self.timerLabel.text = "You can try again"
                for image in self.buttonImage {
                    image.image = UIImage()
                }
            }
        }
    }
    
    func unPauseTimer() {
        allButtonActivate(bool: true)
        timer?.invalidate()
        let total: Int
        switch difficultySegment.selectedSegmentIndex {
        case 0:
            total = 30
        case 1:
            total = 20
        case 2:
            total = 15
        default:
            total = 30
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
            self.progressView.progress = Float(self.timeLeft) / Float(total)
            self.timerLabel.text = "Time:    \(self.timeLeft) seconds"
            
            if self.timeLeft <= 0 {
                self.timer?.invalidate()
                self.showEndAlert()
            }
        }
    }
    
    func hideImageView(tag: Int) {
        for view in buttonImage {
            if view.tag == tag {
                view.image = UIImage()
                break
            }
        }
    }
    
    func showEndAlert() {
        let alert = UIAlertController(
            title: "Time is up",
            message: "Your score: \(game.score)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
        startUI()
    }
    
    func allButtonActivate(bool: Bool) {
        for button in tileButtons {
            button.isEnabled = bool
        }
    }
    
    func oneButtonActivate(tag: Int) {
        for button in tileButtons {
            if button.tag == tag {
                button.isEnabled = true
                break
            }
        }
    }
}


