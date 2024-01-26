import UIKit
import RealmSwift

final class SelectEditViewController: UIViewController {
    @IBOutlet private weak var titleEditTextField: UITextField!
    
    //1問目
    @IBOutlet private weak var contentEditTextView1: UITextView!
    @IBOutlet private weak var choicesEditTextView1of1: UITextView!
    @IBOutlet private weak var choicesEditTextView2of1: UITextView!
    @IBOutlet private weak var choicesEditTextView3of1: UITextView!
    @IBOutlet private weak var choicesEditTextView4of1: UITextView!
    @IBOutlet private weak var answerEditTextView1: UITextView!
    //2問目
    @IBOutlet private weak var contentEditTextView2: UITextView!
    @IBOutlet private weak var choicesEditTextView1of2: UITextView!
    @IBOutlet private weak var choicesEditTextView2of2: UITextView!
    @IBOutlet private weak var choicesEditTextView3of2: UITextView!
    @IBOutlet private weak var choicesEditTextView4of2: UITextView!
    @IBOutlet private weak var answerEditTextView2: UITextView!
    //3問目
    @IBOutlet private weak var contentEditTextView3: UITextView!
    @IBOutlet private weak var choicesEditTextView1of3: UITextView!
    @IBOutlet private weak var choicesEditTextView2of3: UITextView!
    @IBOutlet private weak var choicesEditTextView3of3: UITextView!
    @IBOutlet private weak var choicesEditTextView4of3: UITextView!
    @IBOutlet private weak var answerEditTextView3: UITextView!
    //4問目
    @IBOutlet private weak var contentEditTextView4: UITextView!
    @IBOutlet private weak var choicesEditTextView1of4: UITextView!
    @IBOutlet private weak var choicesEditTextView2of4: UITextView!
    @IBOutlet private weak var choicesEditTextView3of4: UITextView!
    @IBOutlet private weak var choicesEditTextView4of4: UITextView!
    @IBOutlet private weak var answerEditTextView4: UITextView!
    //5問目
    @IBOutlet private weak var contentEditTextView5: UITextView!
    @IBOutlet private weak var choicesEditTextView1of5: UITextView!
    @IBOutlet private weak var choicesEditTextView2of5: UITextView!
    @IBOutlet private weak var choicesEditTextView3of5: UITextView!
    @IBOutlet private weak var choicesEditTextView4of5: UITextView!
    @IBOutlet private weak var answerEditTextView5: UITextView!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBAction private func savaButton(_ sender: UIButton) {
        saveButtonisEnabled()
    }
    
    @IBOutlet private weak var listScrollViewButtom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        setupNotifications()
        setDoneButton()
        
        //解答をpickerViewに変更
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView3.delegate = self
        pickerView3.dataSource = self
        pickerView4.delegate = self
        pickerView4.dataSource = self
        pickerView5.delegate = self
        pickerView5.dataSource = self
        answerEditTextView1.inputView = pickerView1
        answerEditTextView2.inputView = pickerView2
        answerEditTextView3.inputView = pickerView3
        answerEditTextView4.inputView = pickerView4
        answerEditTextView5.inputView = pickerView5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    private let pickerView1 = UIPickerView()
    private let pickerView2 = UIPickerView()
    private let pickerView3 = UIPickerView()
    private let pickerView4 = UIPickerView()
    private let pickerView5 = UIPickerView()
    private(set) var testData = TestDataModel()
    private var list: [String] = ["", "1", "2", "3", "4"]
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
            toolBar.items = [commitButton]
        titleEditTextField.inputAccessoryView = toolBar
        contentEditTextView1.inputAccessoryView = toolBar
        contentEditTextView2.inputAccessoryView = toolBar
        contentEditTextView3.inputAccessoryView = toolBar
        contentEditTextView4.inputAccessoryView = toolBar
        contentEditTextView5.inputAccessoryView = toolBar
        choicesEditTextView1of1.inputAccessoryView = toolBar
        choicesEditTextView2of1.inputAccessoryView = toolBar
        choicesEditTextView3of1.inputAccessoryView = toolBar
        choicesEditTextView4of1.inputAccessoryView = toolBar
        choicesEditTextView1of2.inputAccessoryView = toolBar
        choicesEditTextView2of2.inputAccessoryView = toolBar
        choicesEditTextView3of2.inputAccessoryView = toolBar
        choicesEditTextView4of2.inputAccessoryView = toolBar
        choicesEditTextView1of3.inputAccessoryView = toolBar
        choicesEditTextView2of3.inputAccessoryView = toolBar
        choicesEditTextView3of3.inputAccessoryView = toolBar
        choicesEditTextView4of3.inputAccessoryView = toolBar
        choicesEditTextView1of4.inputAccessoryView = toolBar
        choicesEditTextView2of4.inputAccessoryView = toolBar
        choicesEditTextView3of4.inputAccessoryView = toolBar
        choicesEditTextView4of4.inputAccessoryView = toolBar
        choicesEditTextView1of5.inputAccessoryView = toolBar
        choicesEditTextView2of5.inputAccessoryView = toolBar
        choicesEditTextView3of5.inputAccessoryView = toolBar
        choicesEditTextView4of5.inputAccessoryView = toolBar
        answerEditTextView1.inputAccessoryView = toolBar
        answerEditTextView2.inputAccessoryView = toolBar
        answerEditTextView3.inputAccessoryView = toolBar
        answerEditTextView4.inputAccessoryView = toolBar
        answerEditTextView5.inputAccessoryView = toolBar
    }
    
    func configure(test: TestDataModel) {
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
        titleEditTextField.text = testData.title
        contentEditTextView1.text = testData.testContent1
        contentEditTextView2.text = testData.testContent2
        contentEditTextView3.text = testData.testContent3
        contentEditTextView4.text = testData.testContent4
        contentEditTextView5.text = testData.testContent5
        choicesEditTextView1of1.text = testData.choices1of1
        choicesEditTextView2of1.text = testData.choices2of1
        choicesEditTextView3of1.text = testData.choices3of1
        choicesEditTextView4of1.text = testData.choices4of1
        choicesEditTextView1of2.text = testData.choices1of2
        choicesEditTextView2of2.text = testData.choices2of2
        choicesEditTextView3of2.text = testData.choices3of2
        choicesEditTextView4of2.text = testData.choices4of2
        choicesEditTextView1of3.text = testData.choices1of3
        choicesEditTextView2of3.text = testData.choices2of3
        choicesEditTextView3of3.text = testData.choices3of3
        choicesEditTextView4of3.text = testData.choices4of3
        choicesEditTextView1of4.text = testData.choices1of4
        choicesEditTextView2of4.text = testData.choices2of4
        choicesEditTextView3of4.text = testData.choices3of4
        choicesEditTextView4of4.text = testData.choices4of4
        choicesEditTextView1of5.text = testData.choices1of5
        choicesEditTextView2of5.text = testData.choices2of5
        choicesEditTextView3of5.text = testData.choices3of5
        choicesEditTextView4of5.text = testData.choices4of5
        answerEditTextView1.text = testData.testAnswer1
        answerEditTextView2.text = testData.testAnswer2
        answerEditTextView3.text = testData.testAnswer3
        answerEditTextView4.text = testData.testAnswer4
        answerEditTextView5.text = testData.testAnswer5
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
                    editedTest.choices1of1 = choicesEditTextView1of1.text ?? ""
                    editedTest.choices2of1 = choicesEditTextView2of1.text ?? ""
                    editedTest.choices3of1 = choicesEditTextView3of1.text ?? ""
                    editedTest.choices4of1 = choicesEditTextView4of1.text ?? ""
                    editedTest.choices1of2 = choicesEditTextView1of2.text ?? ""
                    editedTest.choices2of2 = choicesEditTextView2of2.text ?? ""
                    editedTest.choices3of2 = choicesEditTextView3of2.text ?? ""
                    editedTest.choices4of2 = choicesEditTextView4of2.text ?? ""
                    editedTest.choices1of3 = choicesEditTextView1of3.text ?? ""
                    editedTest.choices2of3 = choicesEditTextView2of3.text ?? ""
                    editedTest.choices3of3 = choicesEditTextView3of3.text ?? ""
                    editedTest.choices4of3 = choicesEditTextView4of3.text ?? ""
                    editedTest.choices1of4 = choicesEditTextView1of4.text ?? ""
                    editedTest.choices2of4 = choicesEditTextView2of4.text ?? ""
                    editedTest.choices3of4 = choicesEditTextView3of4.text ?? ""
                    editedTest.choices4of4 = choicesEditTextView4of4.text ?? ""
                    editedTest.choices1of5 = choicesEditTextView1of5.text ?? ""
                    editedTest.choices2of5 = choicesEditTextView2of5.text ?? ""
                    editedTest.choices3of5 = choicesEditTextView3of5.text ?? ""
                    editedTest.choices4of5 = choicesEditTextView4of5.text ?? ""
                    editedTest.testAnswer1 = answerEditTextView1.text ?? ""
                    editedTest.testAnswer2 = answerEditTextView2.text ?? ""
                    editedTest.testAnswer3 = answerEditTextView3.text ?? ""
                    editedTest.testAnswer4 = answerEditTextView4.text ?? ""
                    editedTest.testAnswer5 = answerEditTextView5.text ?? ""
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
            && answerEditTextView1.text.count != 0
            && answerEditTextView2.text.count != 0
            && answerEditTextView3.text.count != 0
            && answerEditTextView4.text.count != 0
            && answerEditTextView5.text.count != 0
            && choicesEditTextView1of1.text.count != 0
            && choicesEditTextView2of1.text.count != 0
            && choicesEditTextView3of1.text.count != 0
            && choicesEditTextView4of1.text.count != 0
            && choicesEditTextView1of2.text.count != 0
            && choicesEditTextView2of2.text.count != 0
            && choicesEditTextView3of2.text.count != 0
            && choicesEditTextView4of2.text.count != 0
            && choicesEditTextView1of3.text.count != 0
            && choicesEditTextView2of3.text.count != 0
            && choicesEditTextView3of3.text.count != 0
            && choicesEditTextView4of3.text.count != 0
            && choicesEditTextView1of4.text.count != 0
            && choicesEditTextView2of4.text.count != 0
            && choicesEditTextView3of4.text.count != 0
            && choicesEditTextView4of4.text.count != 0
            && choicesEditTextView1of5.text.count != 0
            && choicesEditTextView2of5.text.count != 0
            && choicesEditTextView3of5.text.count != 0
            && choicesEditTextView4of5.text.count != 0
            && titleEditTextField.text != "" {
            saveData()
        } else {
            alertLabel.text = "空欄があります。入力してください。"
            alertLabel.textColor = .red
        }
    }
    
}

extension SelectEditViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

extension SelectEditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === pickerView1 {
            answerEditTextView1.text = list[row]
        } else if pickerView === pickerView2 {
            answerEditTextView2.text = list[row]
        } else if pickerView === pickerView3 {
            answerEditTextView3.text = list[row]
        } else if pickerView === pickerView4 {
            answerEditTextView4.text = list[row]
        } else if pickerView === pickerView5 {
            answerEditTextView5.text = list[row]
        }
    }
}
