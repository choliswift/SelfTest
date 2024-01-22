import UIKit
import RealmSwift

final class StartViewController: UIViewController {
    
    @IBOutlet private weak var testCountLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private  weak var inputTextView: UITextView!
    @IBOutlet private weak var correctAnswerLabel: UILabel!
    
    @IBOutlet private weak var bestAnswer: UILabel!
    @IBOutlet private weak var confirmationButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBAction private func confirmationButton(_ sender: UIButton) {
        //ボタンの重複処理を無効にする
        confirmationButton.isEnabled = false
        if inputTextView.text == testData.testAnswer1 {
            bestAnswer.text = "正解！"
        } else {
            bestAnswer.text = "不正解…"
        }
        bestAnswer.isHidden = false
        correctAnswerLabel.isHidden = false
    }
    @IBAction private func nextButton(_ sender: UIButton) {
        //問題が終わった際に次の画面へ向かう。
        performSegue(withIdentifier: "toScoreVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        //setTestData()
        setDoneButton()
        //問題内容の自動改行
        contentLabel.lineBreakMode = .byWordWrapping
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
    
    private(set) var testDataList: [TestDataModel] = []
    
    private var testData = TestDataModel()
    
    private var testCount = 0

    @objc func tapDoneButton() {
        view.endEditing(true)
    }

    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        inputTextView.inputAccessoryView = toolBar
    }

    func setTestData() {
        let config = Realm.Configuration(schemaVersion: 9)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let result = realm.objects(TestDataModel.self)
        testDataList = Array(result)
    }
    
    func configure(test: TestDataModel) {
        testData.id = test.id
        testData.title = test.title
        testData.testContent1 = test.testContent1
        testData.testContent2 = test.testContent2
        testData.testContent3 = test.testContent3
        testData.testContent4 = test.testContent4
        testData.testContent5 = test.testContent5
        testData.testContent6 = test.testContent6
        testData.testContent7 = test.testContent7
        testData.testContent8 = test.testContent8
        testData.testContent9 = test.testContent9
        testData.testContent10 = test.testContent10
        testData.testAnswer1 = test.testAnswer1
        testData.testAnswer2 = test.testAnswer2
        testData.testAnswer3 = test.testAnswer3
        testData.testAnswer4 = test.testAnswer4
        testData.testAnswer5 = test.testAnswer5
        testData.testAnswer6 = test.testAnswer6
        testData.testAnswer7 = test.testAnswer7
        testData.testAnswer8 = test.testAnswer8
        testData.testAnswer9 = test.testAnswer9
        testData.testAnswer10 = test.testAnswer10
    }
    
    func displayData() {
        contentLabel.text = testData.testContent1
        correctAnswerLabel.text = testData.testAnswer1
    }
    
}
