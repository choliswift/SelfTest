import UIKit
import RealmSwift
import AVFoundation

final class StartSelectTestViewController: UIViewController {
    
    @IBOutlet private weak var testCountLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var correctAnswerLabel: UILabel!
    @IBOutlet private weak var bestAnswerLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var judgeImageView: UIImageView!
    
    @IBOutlet private weak var choicesButton1: UIButton!
    @IBOutlet private weak var choicesButton2: UIButton!
    @IBOutlet private weak var choicesButton3: UIButton!
    @IBOutlet private weak var choicesButton4: UIButton!
    
    @IBAction private func choicesButton1(_ sender: UIButton) {
        checkAnswer(buttonTag: sender.tag)
    }
    @IBAction private func choicesButton2(_ sender: UIButton) {
        checkAnswer(buttonTag: sender.tag)
    }
    @IBAction private func choicesButton3(_ sender: UIButton) {
        checkAnswer(buttonTag: sender.tag)
    }
    @IBAction private func choicesButton4(_ sender: UIButton) {
        checkAnswer(buttonTag: sender.tag)
    }
    
    @IBAction private func endButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "問題を終了しますか？", message: "終了するとここまでの正解数のみカウントされます。", preferredStyle: UIAlertController.Style.alert)
        let start = UIAlertAction(title: "はい", style: .destructive) {_ in
            self.performSegue(withIdentifier: "toResultVC", sender: nil)
        }
        let close = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        //実行順に左から並ぶ
        alert.addAction(close)
        alert.addAction(start)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func nextButton(_ sender: UIButton) {
        nextTest()
    }
    
    private(set) var testDataList: [TestDataModel] = []
    private var testData = TestDataModel()
    private var testCount = 1
    private var maxTestCount = 5
    private var answerCount = 0
    private var audioPlayer: AVAudioPlayer?
    
    //結果画面に正解数を渡す処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scoreVC = segue.destination as? ResultSelectTestViewController {
            scoreVC.correct = answerCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        displayData()
        //問題内容の自動改行
        contentLabel.lineBreakMode = .byCharWrapping
        //ボタンをタップした際に問題を表示するように、最初は隠しておく
        correctAnswerLabel.isHidden = true
        bestAnswerLabel.isHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }

    func configureButton() {
        choicesButton1.layer.cornerRadius = choicesButton1.bounds.width / 25
        choicesButton2.layer.cornerRadius = choicesButton2.bounds.width / 25
        choicesButton3.layer.cornerRadius = choicesButton3.bounds.width / 25
        choicesButton4.layer.cornerRadius = choicesButton4.bounds.width / 25
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
        testData.choices1of1 = test.choices1of1
        testData.choices2of1 = test.choices2of1
        testData.choices3of1 = test.choices3of1
        testData.choices4of1 = test.choices4of1
        testData.choices1of2 = test.choices1of2
        testData.choices2of2 = test.choices2of2
        testData.choices3of2 = test.choices3of2
        testData.choices4of2 = test.choices4of2
        testData.choices1of3 = test.choices1of3
        testData.choices2of3 = test.choices2of3
        testData.choices3of3 = test.choices3of3
        testData.choices4of3 = test.choices4of3
        testData.choices1of4 = test.choices1of4
        testData.choices2of4 = test.choices2of4
        testData.choices3of4 = test.choices3of4
        testData.choices4of4 = test.choices4of4
        testData.choices1of5 = test.choices1of5
        testData.choices2of5 = test.choices2of5
        testData.choices3of5 = test.choices3of5
        testData.choices4of5 = test.choices4of5
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
            choicesButton1.setTitle(testData.choices1of1, for: .normal)
            choicesButton2.setTitle(testData.choices2of1, for: .normal)
            choicesButton3.setTitle(testData.choices3of1, for: .normal)
            choicesButton4.setTitle(testData.choices4of1, for: .normal)
            bestAnswerLabel.text = testData.testAnswer1
        } else if testCount == 2 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent2
            choicesButton1.setTitle(testData.choices1of2, for: .normal)
            choicesButton2.setTitle(testData.choices2of2, for: .normal)
            choicesButton3.setTitle(testData.choices3of2, for: .normal)
            choicesButton4.setTitle(testData.choices4of2, for: .normal)
            bestAnswerLabel.text = testData.testAnswer2
        } else if testCount == 3 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent3
            choicesButton1.setTitle(testData.choices1of3, for: .normal)
            choicesButton2.setTitle(testData.choices2of3, for: .normal)
            choicesButton3.setTitle(testData.choices3of3, for: .normal)
            choicesButton4.setTitle(testData.choices4of3, for: .normal)
            bestAnswerLabel.text = testData.testAnswer3
        } else if testCount == 4 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent4
            choicesButton1.setTitle(testData.choices1of4, for: .normal)
            choicesButton2.setTitle(testData.choices2of4, for: .normal)
            choicesButton3.setTitle(testData.choices3of4, for: .normal)
            choicesButton4.setTitle(testData.choices4of4, for: .normal)
            bestAnswerLabel.text = testData.testAnswer4
        } else if testCount == 5 {
            testCountLabel.text = "第\(testCount)問"
            contentLabel.text = testData.testContent5
            choicesButton1.setTitle(testData.choices1of5, for: .normal)
            choicesButton2.setTitle(testData.choices2of5, for: .normal)
            choicesButton3.setTitle(testData.choices3of5, for: .normal)
            choicesButton4.setTitle(testData.choices4of5, for: .normal)
            bestAnswerLabel.text = testData.testAnswer5
        }
        //初期状態ではこの３つを非表示にする
        self.bestAnswerLabel.isHidden = true
        self.correctAnswerLabel.isHidden = true
        self.nextButton.isHidden = true
    }
    //ボタンに設定したタグで正解を判別するために引数を設定。こうすることでボタンを押した際にそれぞれのタグを参照する
    func checkAnswer(buttonTag: Int) {
        if testCount == 1 {
            print(choicesButton4.tag.formatted())
            choicesButton1.isEnabled = false
            choicesButton2.isEnabled = false
            choicesButton3.isEnabled = false
            choicesButton4.isEnabled = false
            if buttonTag.formatted() == testData.testAnswer1 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 2 {
            choicesButton1.isEnabled = false
            choicesButton2.isEnabled = false
            choicesButton3.isEnabled = false
            choicesButton4.isEnabled = false
            if buttonTag.formatted() == testData.testAnswer2 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 3 {
            choicesButton1.isEnabled = false
            choicesButton2.isEnabled = false
            choicesButton3.isEnabled = false
            choicesButton4.isEnabled = false
            if buttonTag.formatted() == testData.testAnswer3 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 4 {
            choicesButton1.isEnabled = false
            choicesButton2.isEnabled = false
            choicesButton3.isEnabled = false
            choicesButton4.isEnabled = false
            if buttonTag.formatted() == testData.testAnswer4 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        } else if testCount == 5 {
            choicesButton1.isEnabled = false
            choicesButton2.isEnabled = false
            choicesButton3.isEnabled = false
            choicesButton4.isEnabled = false
            if buttonTag.formatted() == testData.testAnswer5 {
                correctAnswer()
            } else {
                incorrectAnswer()
            }
            hiddenAnswer()
        }
    }
    //問題が正解時の挙動
    func correctAnswer() {
        correctAnswerLabel.text = "正解！"
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
        correctAnswerLabel.text = "不正解…"
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
            self.bestAnswerLabel.isHidden = false
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
            //次の画面で「どうだ！」ボタンを有効にする
            choicesButton1.isEnabled = true
            choicesButton2.isEnabled = true
            choicesButton3.isEnabled = true
            choicesButton4.isEnabled = true
            //testCountに合わせて問題と回答を更新
            displayData()
        } else {
            //問題が終わった際に次の画面へ向かう。
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
    }
}
