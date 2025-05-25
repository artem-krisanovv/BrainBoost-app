import Foundation

struct QuizBrain {
    let quiz = [
        Question(
            question: "Which country has a flag like that?",
            answers: ["Switzerland", "Angola", "Estonia"],
            correctAnswer: "Switzerland",
            image: "Switzerland"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Finland", "Austria", "Denmark"],
            correctAnswer: "Austria",
            image: "Austria"
        ),
        Question(
            question: "What is the capital of France?",
            answers: ["Rome", "Paris", "Berlin"],
            correctAnswer: "Paris",
            image: "questionImage"
        ),
        Question(
            question: "Which country has the maple leaf?",
            answers: ["Canada", "Australia", "Sweden"],
            correctAnswer: "Canada",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Italy", "Russia", "Romania"],
            correctAnswer: "Romania",
            image: "Romania"
        ),
        Question(
            question: "Where is the Great Wall?",
            answers: ["Japan", "China", "India"],
            correctAnswer: "China",
            image: "questionImage"
        ),
        Question(
            question: "Which flag has a red circle?",
            answers: ["South Korea", "Japan", "Turkey"],
            correctAnswer: "Japan",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Albania", "Azerbaijan", "Armenia"],
            correctAnswer: "Armenia",
            image: "Armenia"
        ),
        Question(
            question: "What about this one?",
            answers: ["Vatican City", "Bahrain", "Cambodia"],
            correctAnswer: "Vatican City",
            image: "Vatican City"
        ),
        Question(
            question: "What language is spoken in Brazil?",
            answers: ["Portuguese", "Spanish", "English"],
            correctAnswer: "Portuguese",
            image: "questionImage"
        ),
        Question(
            question: "Which country is shaped like a boot?",
            answers: ["England", "Greece", "Italy"],
            correctAnswer: "Italy",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Liberia", "Chad", "Ethiopia"],
            correctAnswer: "Liberia",
            image: "Liberia"
        ),
        Question(
            question: "And this?",
            answers: ["Lebanon", "South Ossetia", "Gambia"],
            correctAnswer: "South Ossetia",
            image: "South Ossetia"
        ),
        Question(
            question: "Mount Everest is in:",
            answers: ["Nepal", "Mongolia", "Bhutan"],
            correctAnswer: "Nepal",
            image: "questionImage"
        ),
        Question(
            question: "What is the largest country?",
            answers: ["China", "USA", "Russia"],
            correctAnswer: "Russia",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["New Zealand", "Australia", "Austria"],
            correctAnswer: "Australia",
            image: "Australia"
        ),
        Question(
            question: "What about this flag?",
            answers: ["Georgia", "Kazakhstan", "Estonia"],
            correctAnswer: "Kazakhstan",
            image: "Kazakhstan"
        ),
        Question(
            question: "Which country has pyramids?",
            answers: ["Egypt", "Mexico", "Peru"],
            correctAnswer: "Egypt",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Austria", "Germany", "Belgium"],
            correctAnswer: "Belgium",
            image: "Belgium"
        ),
        Question(
            question: "Which country has the most islands?",
            answers: ["Philippines", "Indonesia", "Sweden"],
            correctAnswer: "Sweden",
            image: "questionImage"
        ),
        Question(
            question: "Which flag is blue and yellow?",
            answers: ["Ukraine", "Finland", "Greece"],
            correctAnswer: "Ukraine",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Bulgaria", "Morocco", "Poland"],
            correctAnswer: "Poland",
            image: "Poland"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Croatia", "Czech Republic", "Estonia"],
            correctAnswer: "Czech Republic",
            image: "Czech Republic"
        ),
        Question(
            question: "And this?",
            answers: ["Eritrea", "Liberia", "United States"],
            correctAnswer: "United States",
            image: "United States"
        ),
        Question(
            question: "Which desert is the largest?",
            answers: ["Sahara", "Gobi", "Kalahari"],
            correctAnswer: "Sahara",
            image: "questionImage"
        ),
        Question(
            question: "Which country has Big Ben?",
            answers: ["Philippines", "Germany", "England"],
            correctAnswer: "England",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Ukraine", "France", "Grenada"],
            correctAnswer: "Ukraine",
            image: "Ukraine"
        ),
        Question(
            question: "What about this one?",
            answers: ["Gambia", "Bhutan", "Honduras"],
            correctAnswer: "Bhutan",
            image: "Bhutan"
        ),
        Question(
            question: "Which ocean is the deepest?",
            answers: ["Arctic", "Atlantic", "Pacific"],
            correctAnswer: "Pacific",
            image: "questionImage"
        ),
        Question(
            question: "Where is the Eiffel Tower?",
            answers: ["Paris", "London", "Brussels"],
            correctAnswer: "Paris",
            image: "questionImage"
        ),
        Question(
            question: "Which country has a flag like that?",
            answers: ["Slovakia", "Russia", "Slovenia"],
            correctAnswer: "Russia",
            image: "Russia"
        ),
        Question(
            question: "And that about last one?",
            answers: ["Monaco", "Poland", "Indonesia"],
            correctAnswer: "Monaco",
            image: "Monaco"
        ),
    ]
    var questionNumber = 0
    var score = 0
    
    mutating func nextQuestion() {
        questionNumber += 1
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].correctAnswer {
            score += 1
            return true
        } else {
            score -= 1
            return false
        }
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].question
    }
    
    func getAnswers(buttonNumber: String) -> String {
        return quiz[questionNumber].answers[Int(buttonNumber) ?? 0]
    }
    
    func getImageName() -> String {
        return quiz[questionNumber].image
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
}
