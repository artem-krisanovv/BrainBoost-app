import UIKit

class TileViewController: UIViewController {
    
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
    
    @IBAction func backToMainButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        timeLeft = game.getSegmentValue(index: sender.selectedSegmentIndex)
        timerLabel.text = "Time:    \(timeLeft) seconds"
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
                if buttonImage[button.tag].image == nil {
                    button.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startTimer()
        game.generaterTiles()
        allButtonActivate(bool: true)
        startSettings()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag
        var tileImageView: UIImageView = UIImageView()
        for view in buttonImage {
            if view.tag == tag {
                tileImageView = view
                break
            }
        }
        guard let correctTile = game.returnTile(tag: tag), !correctTile.isChoiceMatches else { return }
        UIView.transition(
            with: tileImageView,
            duration: 0.55,
            options: .transitionFlipFromLeft,
            animations: {
                tileImageView.image = UIImage(
                    named: correctTile.imagesNumber
                )
                tileImageView.backgroundColor = .clear
            },
            completion: nil)
        sender.isEnabled = false
        if let first = tagOfFirstButton {
            if let firstTile = game.returnTile(tag: first), firstTile.imagesNumber == correctTile.imagesNumber {
                markMatched(firstTag: first, secondTag: tag)
                tagOfFirstButton = nil
                pointsLabel.text = "\(game.score)"
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.88) {
                    self.flipBack(tag: tag)
                    self.flipBack(tag: first)
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
        view.addGradient()
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
        progressView.progress = 1
        startSettings()
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
            }
        }
    }
    
    func unPauseTimer() {
        allButtonActivate(bool: true)
        timer?.invalidate()
        let total = game.getSegmentValue(index: difficultySegment.selectedSegmentIndex)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
            self.progressView.progress = Float(self.timeLeft) / Float(total)
            self.timerLabel.text = "Time:    \(self.timeLeft) seconds"
            
            if self.timeLeft <= 0 {
                self.timer?.invalidate()
                self.showEndAlert()
                self.timerLabel.text = "You can try again"
            }
        }
    }
    
    func markMatched(firstTag: Int, secondTag: Int) {
        var firstIndex: Int? = nil
        var secondIndex: Int? = nil
        for (index, tile) in game.tiles.enumerated() {
            guard firstIndex == nil || secondIndex == nil else { break }
            if tile.tag == firstTag {
                firstIndex = index
            }
            if tile.tag == secondTag {
                secondIndex = index
            }
        }
        if let firstIndex = firstIndex, let secondIndex = secondIndex {
            game.tiles[firstIndex].isChoiceMatches = true
            game.tiles[secondIndex].isChoiceMatches = true
            game.score += 1
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
        startSettings()
        allButtonActivate(bool: false)
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
    func startSettings() {
        pointsLabel.text = "0"
        tagOfFirstButton = nil
        stopButton.setTitle("Stop", for: .normal)
        timerLabel.text = "Time:    \(timeLeft) seconds"
        game.score = 0
        progressView.setProgress(1, animated: true)
        for imageView in buttonImage {
            imageView.backgroundColor = UIColor(
                red: 0.667,
                green: 0.553,
                blue: 1,
                alpha: 1
            )
            imageView.image = UIImage()
            imageView.isUserInteractionEnabled = true
        }
    }
    
    func flipBack(tag: Int) {
        for view in buttonImage {
            if view.tag == tag {
                UIView.transition(with: view, duration: 0.66, options: .transitionFlipFromRight, animations: {
                        view.image = nil
                        view.backgroundColor = UIColor(
                            red: 0.667,
                            green: 0.553,
                            blue: 1,
                            alpha: 1
                        )
                    },
                    completion: nil)
                break
            }
        }
    }
}





