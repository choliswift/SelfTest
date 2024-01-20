import UIKit
import RealmSwift

protocol TestCountedDelegate {
    func testCountLabelData(textCounted: Int)
}

final class SentenceCreateViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        saveData()
    }
    @IBOutlet weak var listScrollView: UIScrollView!
    @IBOutlet weak var listScrollViewButtom: NSLayoutConstraint!
    //ひとつだけ設定して、あとはそれぞれにタグつけるやり方でもできるかもしれない
    @IBOutlet weak var contentTextView1: UITextView!
    @IBOutlet weak var answerTextView1: UITextView!
    @IBOutlet weak var contentTextView2: UITextView!
    @IBOutlet weak var answerTextView2: UITextView!
    @IBOutlet weak var contentTextView3: UITextView!
    @IBOutlet weak var answerTextView3: UITextView!
    @IBOutlet weak var contentTextView4: UITextView!
    @IBOutlet weak var answerTextView4: UITextView!
    @IBOutlet weak var contentTextView5: UITextView!
    @IBOutlet weak var answerTextView5: UITextView!
    @IBOutlet weak var contentTextView6: UITextView!
    @IBOutlet weak var answerTextView6: UITextView!
    @IBOutlet weak var contentTextView7: UITextView!
    @IBOutlet weak var answerTextView7: UITextView!
    @IBOutlet weak var contentTextView8: UITextView!
    @IBOutlet weak var answerTextView8: UITextView!
    @IBOutlet weak var contentTextView9: UITextView!
    @IBOutlet weak var answerTextView9: UITextView!
    @IBOutlet weak var contentTextView10: UITextView!
    @IBOutlet weak var answerTextView10: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneButton()
        setupNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private var testDataList: [TestDataModel] = []
    private var testData = TestDataModel()
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        titleTextField.inputAccessoryView = toolBar
        contentTextView1.inputAccessoryView = toolBar
        contentTextView2.inputAccessoryView = toolBar
        contentTextView3.inputAccessoryView = toolBar
        contentTextView4.inputAccessoryView = toolBar
        contentTextView5.inputAccessoryView = toolBar
        contentTextView6.inputAccessoryView = toolBar
        contentTextView7.inputAccessoryView = toolBar
        contentTextView8.inputAccessoryView = toolBar
        contentTextView9.inputAccessoryView = toolBar
        contentTextView10.inputAccessoryView = toolBar
        answerTextView1.inputAccessoryView = toolBar
        answerTextView2.inputAccessoryView = toolBar
        answerTextView3.inputAccessoryView = toolBar
        answerTextView4.inputAccessoryView = toolBar
        answerTextView5.inputAccessoryView = toolBar
        answerTextView6.inputAccessoryView = toolBar
        answerTextView7.inputAccessoryView = toolBar
        answerTextView8.inputAccessoryView = toolBar
        answerTextView9.inputAccessoryView = toolBar
        answerTextView10.inputAccessoryView = toolBar
    }
    
    func saveData() { //保存する内容の書き方を修正する必要がある
        let config = Realm.Configuration(schemaVersion: 9)
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        try! realm.write {
            testData.title = titleTextField.text ?? ""
            testData.testContent1 = contentTextView1.text ?? ""
            testData.testContent2 = contentTextView2.text ?? ""
            testData.testContent3 = contentTextView3.text ?? ""
            testData.testContent4 = contentTextView4.text ?? ""
            testData.testContent5 = contentTextView5.text ?? ""
            testData.testContent6 = contentTextView6.text ?? ""
            testData.testContent7 = contentTextView7.text ?? ""
            testData.testContent8 = contentTextView8.text ?? ""
            testData.testContent9 = contentTextView9.text ?? ""
            testData.testContent10 = contentTextView10.text ?? ""
            testData.testAnswer1 = answerTextView1.text ?? ""
            testData.testAnswer2 = answerTextView2.text ?? ""
            testData.testAnswer3 = answerTextView3.text ?? ""
            testData.testAnswer4 = answerTextView4.text ?? ""
            testData.testAnswer5 = answerTextView5.text ?? ""
            testData.testAnswer6 = answerTextView6.text ?? ""
            testData.testAnswer7 = answerTextView7.text ?? ""
            testData.testAnswer8 = answerTextView8.text ?? ""
            testData.testAnswer9 = answerTextView9.text ?? ""
            testData.testAnswer10 = answerTextView10.text ?? ""
            testData.kind = 1
            realm.add(testData)
        }
        //保存したら一番最初の画面に戻るように処理
        self.navigationController?.popToRootViewController(animated: true)
    }
    //キーボードを表示した際にtextViewが隠れないようにする処理
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillClose), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(_ notification: Notification) {
        print("キーボード表示")
        //キーボードのサイズ
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              //キーボードのアニメーション時間を設定
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              //キーボードのアニメーションの曲線
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              //Outletで結びつけたlistScrollViewのButtomをここで制約
              let scrollViewButtomConstraint = self.listScrollViewButtom else { return }
        
        //キーボードの高さを読み込む
        let keyboardHeight = keyboardFrame.height
        //scrollViewのButtomを再設定
        scrollViewButtomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func keyboardWillClose(_ notification: Notification) {
        //キーボードのアニメーション時間を設定
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              //キーボードのアニメーションの曲線
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              //Outletで結びつけたlistScrollViewのButtomをここで制約
              let scrollViewButtomConstraint = self.listScrollViewButtom else { return }
        
        //scrollViewのButtomを再設定
        scrollViewButtomConstraint.constant = 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension SentenceCreateViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
