import Foundation
import UIKit
import RealmSwift
import AVFoundation

final class StartFiveSentenceTestViewController: UIViewController {
    @IBOutlet private weak var testCountLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var inputTextView: UITextView!
    @IBOutlet private weak var correctAnswerLabel: UILabel!
    
    @IBOutlet private weak var bestAnswer: UILabel!
    @IBOutlet private weak var confirmationButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBAction private func confirmationButton(_ sender: UIButton) {
        checkAnswer()
    }
    @IBAction private func nextButton(_ sender: UIButton) {
        nextTest()
    }
    @IBOutlet private weak var endButton: UIButton!
    
    @IBAction func endButon(_ sender: UIButton) {
        let alert = UIAlertController(title: "問題を終了しますか？", message: "終了するとここまでの正解数のみカウントされます。", preferredStyle: UIAlertController.Style.alert)
        let start = UIAlertAction(title: "はい", style: .destructive) {_ in
            self.performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
        let close = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        //実行順に左から並ぶ
        alert.addAction(close)
        alert.addAction(start)
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var judgeImageView: UIImageView!
    
    private(set) var testDataList: [TestDataModel] = []
    private var testData = TestDataModel()
    private var testCount = 1
    private var maxTestCount = 5
    private var answerCount = 0
    private var audioPlayer: AVAudioPlayer?
    
    //結果画面に正解数を渡す処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scoreVC = segue.destination as? ResultFiveTestViewController {
            scoreVC.correct = answerCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        displayData()
        //setTestData()
        setDoneButton()
        //問題内容の自動改行
        contentLabel.lineBreakMode = .byCharWrapping
        //ボタンをタップした際に問題を表示するように、最初は隠しておく
        correctAnswerLabel.isHidden = true
        bestAnswer.isHidden = true
        
        inputTextView.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.7)
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.cornerRadius = 10.0
        inputTextView.layer.masksToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func tapDoneButton() {
        view.endEditing(true)
    }

    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        inputTextView.inputAccessoryView = toolBar
    }
    
    func configureButton() {
        confirmationButton.layer.cornerRadius = confirmationButton.bounds.width / 7
        nextButton.layer.cornerRadius = nextButton.bounds.width / 9
    }

    func setTestData() {
        let config = Realm.Configuration(schemaVersion: 9)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let result = realm.objects(TestDataModel.self)
        testDataList = Array(result)
    }
    
    func configure(test: TestDataModel) {
        //保存したテストの内容を読み込み
        testData.id = test.id
        testData.title = test.title
        testData.testContent1 = test.testContent1
        testData.testContent2 = test.testContent2
        testData.testContent3 = test.testContent3
        testData.testContent4 = test.testContent4
        testData.testContent5 = test.testContent5
        testData.testAnswer1 = test.testAnswer1
        testData.testAnswer2 = test.testAnswer2
        testData.testAnswer3 = test.testAnswer3
        testData.testAnswer4 = test.testAnswer4
        testData.testAnswer5 = test.testAnswer5
    }
    
    func displayData() {
        //testCountを利用して問題を順番に表示。負荷を軽減するために、同一のStoryboardで処理
        if testCount == 1 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent1
            correctAnswerLabel.text = testData.testAnswer1
        } else if testCount == 2 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent2
            correctAnswerLabel.text = testData.testAnswer2
        } else if testCount == 3 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent3
            correctAnswerLabel.text = testData.testAnswer3
        } else if testCount == 4 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent4
            correctAnswerLabel.text = testData.testAnswer4
        } else if testCount == 5 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent5
            correctAnswerLabel.text = testData.testAnswer5
        }
        //初期状態ではこの３つを非表示にする
        self.bestAnswer.isHidden = true
        self.correctAnswerLabel.isHidden = true
        self.nextButton.isHidden = true
    }
    
    func checkAnswer() {
        if testCount == 1 {
            confirmationButton.isEnabled = false
            if inputTextView.text == testData.testAnswer1 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 2 {
            confirmationButton.isEnabled = false
            if inputTextView.text == testData.testAnswer2 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 3 {
            confirmationButton.isEnabled = false
            if inputTextView.text == testData.testAnswer3 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 4 {
            confirmationButton.isEnabled = false
            if inputTextView.text == testData.testAnswer4 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 5 {
            confirmationButton.isEnabled = false
            if inputTextView.text == testData.testAnswer5 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        }
    }
    //問題が正解時の挙動
    func correctAnswer() {
        bestAnswer.text = "正解！"
        judgeImageView.image = UIImage(named: "correct")
        //judgeImageViewが非表示になっているのを表示させる
        judgeImageView.isHidden = false
        //1秒後にjudgeImageViewを隠す
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.judgeImageView.isHidden = true
        }
        playSoundWithVolume(name: "クイズ正解", type: "mp3", volume: 1)
        answerCount += 1
    }
    //問題が不正解時の挙動
    func incorrectAnswer() {
        bestAnswer.text = "不正解…"
        judgeImageView.image = UIImage(named: "incorrect")
        //judgeImageViewが非表示になっているのを表示させる
        judgeImageView.isHidden = false
        //1秒後にjudgeImageViewを隠す
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.judgeImageView.isHidden = true
        }
        playSoundWithVolume(name: "クイズ不正解", type: "mp3", volume: 1)
    }
    //「どうだ！」ボタンをタップした際、正解と「次へ」ボタンを1秒後に表示にする
    func hiddenAnswer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.bestAnswer.isHidden = false
            self.correctAnswerLabel.isHidden = false
            self.nextButton.isHidden = false
        }
    }
    
    func playSoundWithVolume(name: String, type: String, volume: Float) {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = volume
                audioPlayer?.play()
            } catch {
                print("再生失敗")
            }
        }
    }
    func nextTest() {
        if testCount < maxTestCount {
            testCount += 1
            //次の画面で入力フィールドを空白に
            inputTextView.text = ""
            //次の画面で「どうだ！」ボタンを有効にする
            confirmationButton.isEnabled = true
            //testCountに合わせて問題と回答を更新
            displayData()
        } else {
            //問題が終わった際に次の画面へ向かう。
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
}
