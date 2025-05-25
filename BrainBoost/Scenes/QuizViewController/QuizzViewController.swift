import UIKit

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageForQuestion: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateToStartView()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if quizBrain.questionNumber < quizBrain.quiz.count - 1 {
            let userAnswer = sender.currentTitle ?? ""
            let userGotItRight = quizBrain.checkAnswer(userAnswer)
            if userGotItRight {
                questionLabel.textColor = .green
                Timer.scheduledTimer(
                    timeInterval: 0.666,
                    target: self,
                    selector: #selector(updateUi),
                    userInfo: nil,
                    repeats: false
                )
                quizBrain.nextQuestion()
                questionNumberLabel.text = "Question \(quizBrain.questionNumber + 1)"
            } else {
                questionLabel.textColor = .red
                Timer.scheduledTimer(
                    timeInterval: 0.666,
                    target: self,
                    selector: #selector(anUpdateUi),
                    userInfo: nil,
                    repeats: false
                )
            }
        } else {
            showEndAlert()
        }
    }
    
    func updateToStartView() {
        quizBrain.score = 0
        quizBrain.questionNumber = 0
        questionLabel.text = quizBrain.getQuestionText()
        questionNumberLabel.text = "Question \(quizBrain.questionNumber + 1)"
        progressView.progress = quizBrain.getProgress()
        imageForQuestion.image = UIImage(named: quizBrain.getImageName())
        firstButton.setTitle(quizBrain.getAnswers(buttonNumber: "0"), for: .normal)
        secondButton.setTitle(quizBrain.getAnswers(buttonNumber: "1"), for: .normal)
        thirdButton.setTitle(quizBrain.getAnswers(buttonNumber: "2"), for: .normal)
        view.addGradient()
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        progressView.layer.borderWidth = 0.88
        progressView.layer.borderColor = UIColor.white.cgColor
        imageForQuestion.layer.borderWidth = 1
        imageForQuestion.layer.borderColor = UIColor(red: 0.46, green: 0.28, blue: 1, alpha: 1).cgColor
        firstButton.layer.borderWidth = 0.88
        firstButton.layer.borderColor = UIColor.white.cgColor
        secondButton.layer.borderWidth = 0.88
        secondButton.layer.borderColor = UIColor.white.cgColor
        thirdButton.layer.borderWidth = 0.88
        thirdButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func updateUi() {
        questionLabel.text = quizBrain.getQuestionText()
        questionLabel.textColor = UIColor(red: 0.157, green: 0.039, blue: 0.51, alpha: 1)
        progressView.progress = quizBrain.getProgress()
        imageForQuestion.image = UIImage(named: quizBrain.getImageName())
        firstButton.setTitle(quizBrain.getAnswers(buttonNumber: "0"), for: .normal)
        secondButton.setTitle(quizBrain.getAnswers(buttonNumber: "1"), for: .normal)
        thirdButton.setTitle(quizBrain.getAnswers(buttonNumber: "2"), for: .normal)
    }
    
    @objc func anUpdateUi() {
        questionLabel.textColor = UIColor(red: 0.157, green: 0.039, blue: 0.51, alpha: 1)
    }
    
    func showEndAlert() {
        let alert = UIAlertController(
            title: "Congratulations!",
            message: "You've answered all the questions, score: \(quizBrain.score) out of 31",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
        updateToStartView()
    }
}
