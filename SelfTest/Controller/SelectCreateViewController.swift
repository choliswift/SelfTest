import UIKit
import RealmSwift

class SelectCreateViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBAction private func saveButton(_ sender: UIButton) {
        saveButtonisEnabled()
    }
    @IBOutlet private weak var listScrollView: UIScrollView!
    @IBOutlet private weak var listScrollViewButtom: NSLayoutConstraint!
    //1問目
    @IBOutlet private weak var contentTextView1: UITextView!
    @IBOutlet private weak var choicesTextView1of1: UITextView!
    @IBOutlet private weak var choicesTextView2of1: UITextView!
    @IBOutlet private weak var choicesTextView3of1: UITextView!
    @IBOutlet private weak var choicesTextView4of1: UITextView!
    @IBOutlet private weak var answerTextView1: UITextView!
    //2問目
    @IBOutlet private weak var contentTextView2: UITextView!
    @IBOutlet private weak var choicesTextView1of2: UITextView!
    @IBOutlet private weak var choicesTextView2of2: UITextView!
    @IBOutlet private weak var choicesTextView3of2: UITextView!
    @IBOutlet private weak var choicesTextView4of2: UITextView!
    @IBOutlet private weak var answerTextView2: UITextView!
    //3問目
    @IBOutlet private weak var contentTextView3: UITextView!
    @IBOutlet private weak var choicesTextView1of3: UITextView!
    @IBOutlet private weak var choicesTextView2of3: UITextView!
    @IBOutlet private weak var choicesTextView3of3: UITextView!
    @IBOutlet private weak var choicesTextView4of3: UITextView!
    @IBOutlet private weak var answerTextView3: UITextView!
    //4問目
    @IBOutlet private weak var contentTextView4: UITextView!
    @IBOutlet private weak var choicesTextView1of4: UITextView!
    @IBOutlet private weak var choicesTextView2of4: UITextView!
    @IBOutlet private weak var choicesTextView3of4: UITextView!
    @IBOutlet private weak var choicesTextView4of4: UITextView!
    @IBOutlet private weak var answerTextView4: UITextView!
    //5問目
    @IBOutlet private weak var contentTextView5: UITextView!
    @IBOutlet private weak var choicesTextView1of5: UITextView!
    @IBOutlet private weak var choicesTextView2of5: UITextView!
    @IBOutlet private weak var choicesTextView3of5: UITextView!
    @IBOutlet private weak var choicesTextView4of5: UITextView!
    @IBOutlet private weak var answerTextView5: UITextView!
    
    @IBOutlet weak var alertLabel: UILabel!
    
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
        choicesTextView1of1.inputAccessoryView = toolBar
        choicesTextView2of1.inputAccessoryView = toolBar
        choicesTextView3of1.inputAccessoryView = toolBar
        choicesTextView4of1.inputAccessoryView = toolBar
        choicesTextView1of2.inputAccessoryView = toolBar
        choicesTextView2of2.inputAccessoryView = toolBar
        choicesTextView3of2.inputAccessoryView = toolBar
        choicesTextView4of2.inputAccessoryView = toolBar
        choicesTextView1of3.inputAccessoryView = toolBar
        choicesTextView2of3.inputAccessoryView = toolBar
        choicesTextView3of3.inputAccessoryView = toolBar
        choicesTextView4of3.inputAccessoryView = toolBar
        choicesTextView1of4.inputAccessoryView = toolBar
        choicesTextView2of4.inputAccessoryView = toolBar
        choicesTextView3of4.inputAccessoryView = toolBar
        choicesTextView4of4.inputAccessoryView = toolBar
        choicesTextView1of5.inputAccessoryView = toolBar
        choicesTextView2of5.inputAccessoryView = toolBar
        choicesTextView3of5.inputAccessoryView = toolBar
        choicesTextView4of5.inputAccessoryView = toolBar
        answerTextView1.inputAccessoryView = toolBar
        answerTextView2.inputAccessoryView = toolBar
        answerTextView3.inputAccessoryView = toolBar
        answerTextView4.inputAccessoryView = toolBar
        answerTextView5.inputAccessoryView = toolBar
    }
    
    func saveData() { //保存する内容の書き方を修正する必要がある
        let config = Realm.Configuration(schemaVersion: 11)
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        try! realm.write {
            testData.title = titleTextField.text ?? ""
            testData.testContent1 = contentTextView1.text ?? ""
            testData.testContent2 = contentTextView2.text ?? ""
            testData.testContent3 = contentTextView3.text ?? ""
            testData.testContent4 = contentTextView4.text ?? ""
            testData.testContent5 = contentTextView5.text ?? ""
            testData.choices1of1 = choicesTextView1of1.text ?? ""
            testData.choices2of1 = choicesTextView2of1.text ?? ""
            testData.choices3of1 = choicesTextView3of1.text ?? ""
            testData.choices4of1 = choicesTextView4of1.text ?? ""
            testData.choices1of2 = choicesTextView1of2.text ?? ""
            testData.choices2of2 = choicesTextView2of2.text ?? ""
            testData.choices3of2 = choicesTextView3of2.text ?? ""
            testData.choices4of2 = choicesTextView4of2.text ?? ""
            testData.choices1of3 = choicesTextView1of3.text ?? ""
            testData.choices2of3 = choicesTextView2of3.text ?? ""
            testData.choices3of3 = choicesTextView3of3.text ?? ""
            testData.choices4of3 = choicesTextView4of3.text ?? ""
            testData.choices1of4 = choicesTextView1of4.text ?? ""
            testData.choices2of4 = choicesTextView2of4.text ?? ""
            testData.choices3of4 = choicesTextView3of4.text ?? ""
            testData.choices4of4 = choicesTextView4of4.text ?? ""
            testData.choices1of5 = choicesTextView1of5.text ?? ""
            testData.choices2of5 = choicesTextView2of5.text ?? ""
            testData.choices3of5 = choicesTextView3of5.text ?? ""
            testData.choices4of5 = choicesTextView4of5.text ?? ""
            testData.testAnswer1 = answerTextView1.text ?? ""
            testData.testAnswer2 = answerTextView2.text ?? ""
            testData.testAnswer3 = answerTextView3.text ?? ""
            testData.testAnswer4 = answerTextView4.text ?? ""
            testData.testAnswer5 = answerTextView5.text ?? ""
            testData.kind = 2
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
    //未入力があった際に保存できないようにする
    func saveButtonisEnabled() {
        if contentTextView1.text.count != 0
            && contentTextView2.text.count != 0
            && contentTextView3.text.count != 0
            && contentTextView4.text.count != 0
            && contentTextView5.text.count != 0
            && answerTextView1.text.count != 0
            && answerTextView2.text.count != 0
            && answerTextView3.text.count != 0
            && answerTextView4.text.count != 0
            && answerTextView5.text.count != 0
            && choicesTextView1of1.text.count != 0
            && choicesTextView2of1.text.count != 0
            && choicesTextView3of1.text.count != 0
            && choicesTextView4of1.text.count != 0
            && choicesTextView1of2.text.count != 0
            && choicesTextView2of2.text.count != 0
            && choicesTextView3of2.text.count != 0
            && choicesTextView4of2.text.count != 0
            && choicesTextView1of3.text.count != 0
            && choicesTextView2of3.text.count != 0
            && choicesTextView3of3.text.count != 0
            && choicesTextView4of3.text.count != 0
            && choicesTextView1of4.text.count != 0
            && choicesTextView2of4.text.count != 0
            && choicesTextView3of4.text.count != 0
            && choicesTextView4of4.text.count != 0
            && choicesTextView1of5.text.count != 0
            && choicesTextView2of5.text.count != 0
            && choicesTextView3of5.text.count != 0
            && choicesTextView4of5.text.count != 0
            && titleTextField.text != "" {
            saveData()
        } else {
            alertLabel.text = "空欄があります。入力してください。"
            alertLabel.textColor = .red
        }
    }
}

extension SelectCreateViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}