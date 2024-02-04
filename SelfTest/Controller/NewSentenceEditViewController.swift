import UIKit
import RealmSwift

final class NewSentenceEditViewController: UIViewController {
    @IBOutlet private weak var titleEditTextField: UITextField!
    //多分、タグ付けでリファクタリングできる
    @IBOutlet private weak var contentEditTextView1: UITextView!
    @IBOutlet private weak var answerEditTextView1: UITextView!
    @IBOutlet private weak var contentEditTextView2: UITextView!
    @IBOutlet private weak var answerEditTextView2: UITextView!
    @IBOutlet private weak var contentEditTextView3: UITextView!
    @IBOutlet private weak var answerEditTextView3: UITextView!
    @IBOutlet private weak var contentEditTextView4: UITextView!
    @IBOutlet private weak var answerEditTextView4: UITextView!
    @IBOutlet private weak var contentEditTextView5: UITextView!
    @IBOutlet private weak var answerEditTextView5: UITextView!
    @IBOutlet private weak var contentEditTextView6: UITextView!
    @IBOutlet private weak var answerEditTextView6: UITextView!
    @IBOutlet private weak var contentEditTextView7: UITextView!
    @IBOutlet private weak var answerEditTextView7: UITextView!
    @IBOutlet private weak var contentEditTextView8: UITextView!
    @IBOutlet private weak var answerEditTextView8: UITextView!
    @IBOutlet private weak var contentEditTextView9: UITextView!
    @IBOutlet private weak var answerEditTextView9: UITextView!
    @IBOutlet private weak var contentEditTextView10: UITextView!
    @IBOutlet private weak var answerEditTextView10: UITextView!
    
    @IBOutlet private weak var alertLabel: UILabel!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBAction private func savaButton(_ sender: UIButton) {
        saveButtonisEnabled()
    }
    
    @IBOutlet private weak var listScrollViewButtom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    private(set) var testData = TestDataModel()
    private let toolbarWidthValue = 320
    private let toolbarHeightValue = 40
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: toolbarWidthValue, height: toolbarHeightValue))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        titleEditTextField.inputAccessoryView = toolBar
        contentEditTextView1.inputAccessoryView = toolBar
        contentEditTextView2.inputAccessoryView = toolBar
        contentEditTextView3.inputAccessoryView = toolBar
        contentEditTextView4.inputAccessoryView = toolBar
        contentEditTextView5.inputAccessoryView = toolBar
        contentEditTextView6.inputAccessoryView = toolBar
        contentEditTextView7.inputAccessoryView = toolBar
        contentEditTextView8.inputAccessoryView = toolBar
        contentEditTextView9.inputAccessoryView = toolBar
        contentEditTextView10.inputAccessoryView = toolBar
        answerEditTextView1.inputAccessoryView = toolBar
        answerEditTextView2.inputAccessoryView = toolBar
        answerEditTextView3.inputAccessoryView = toolBar
        answerEditTextView4.inputAccessoryView = toolBar
        answerEditTextView5.inputAccessoryView = toolBar
        answerEditTextView6.inputAccessoryView = toolBar
        answerEditTextView7.inputAccessoryView = toolBar
        answerEditTextView8.inputAccessoryView = toolBar
        answerEditTextView9.inputAccessoryView = toolBar
        answerEditTextView10.inputAccessoryView = toolBar
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
        titleEditTextField.text = testData.title
        contentEditTextView1.text = testData.testContent1
        contentEditTextView2.text = testData.testContent2
        contentEditTextView3.text = testData.testContent3
        contentEditTextView4.text = testData.testContent4
        contentEditTextView5.text = testData.testContent5
        contentEditTextView6.text = testData.testContent6
        contentEditTextView7.text = testData.testContent7
        contentEditTextView8.text = testData.testContent8
        contentEditTextView9.text = testData.testContent9
        contentEditTextView10.text = testData.testContent10
        answerEditTextView1.text = testData.testAnswer1
        answerEditTextView2.text = testData.testAnswer2
        answerEditTextView3.text = testData.testAnswer3
        answerEditTextView4.text = testData.testAnswer4
        answerEditTextView5.text = testData.testAnswer5
        answerEditTextView6.text = testData.testAnswer6
        answerEditTextView7.text = testData.testAnswer7
        answerEditTextView8.text = testData.testAnswer8
        answerEditTextView9.text = testData.testAnswer9
        answerEditTextView10.text = testData.testAnswer10
    }
    
    func saveData() {
        let realm = try! Realm()
            if let editedTest = realm.object(ofType: TestDataModel.self, forPrimaryKey: testData.id) {
                try! realm.write {
                    editedTest.title = titleEditTextField.text ?? ""
                    editedTest.testContent1 = contentEditTextView1.text ?? ""
                    editedTest.testContent2 = contentEditTextView2.text ?? ""
                    editedTest.testContent3 = contentEditTextView3.text ?? ""
                    editedTest.testContent4 = contentEditTextView4.text ?? ""
                    editedTest.testContent5 = contentEditTextView5.text ?? ""
                    editedTest.testContent6 = contentEditTextView6.text ?? ""
                    editedTest.testContent7 = contentEditTextView7.text ?? ""
                    editedTest.testContent8 = contentEditTextView8.text ?? ""
                    editedTest.testContent9 = contentEditTextView9.text ?? ""
                    editedTest.testContent10 = contentEditTextView10.text ?? ""
                    editedTest.testAnswer1 = answerEditTextView1.text ?? ""
                    editedTest.testAnswer2 = answerEditTextView2.text ?? ""
                    editedTest.testAnswer3 = answerEditTextView3.text ?? ""
                    editedTest.testAnswer4 = answerEditTextView4.text ?? ""
                    editedTest.testAnswer5 = answerEditTextView5.text ?? ""
                    editedTest.testAnswer6 = answerEditTextView6.text ?? ""
                    editedTest.testAnswer7 = answerEditTextView7.text ?? ""
                    editedTest.testAnswer8 = answerEditTextView8.text ?? ""
                    editedTest.testAnswer9 = answerEditTextView9.text ?? ""
                    editedTest.testAnswer10 = answerEditTextView10.text ?? ""
                    realm.add(editedTest, update: .modified)
                }
            }
        self.navigationController?.popViewController(animated: true)
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
        if contentEditTextView1.text.count != 0
            && contentEditTextView2.text.count != 0
            && contentEditTextView3.text.count != 0
            && contentEditTextView4.text.count != 0
            && contentEditTextView5.text.count != 0
            && contentEditTextView6.text.count != 0
            && contentEditTextView7.text.count != 0
            && contentEditTextView8.text.count != 0
            && contentEditTextView9.text.count != 0
            && contentEditTextView10.text.count != 0
            && answerEditTextView1.text.count != 0
            && answerEditTextView2.text.count != 0
            && answerEditTextView3.text.count != 0
            && answerEditTextView4.text.count != 0
            && answerEditTextView5.text.count != 0
            && answerEditTextView6.text.count != 0
            && answerEditTextView7.text.count != 0
            && answerEditTextView8.text.count != 0
            && answerEditTextView8.text.count != 0
            && answerEditTextView10.text.count != 0
            && titleEditTextField.text != "" {
            saveData()
        } else {
            alertLabel.text = "空欄があります。入力してください。"
            alertLabel.textColor = .red
        }
    }
}

extension NewSentenceEditViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
