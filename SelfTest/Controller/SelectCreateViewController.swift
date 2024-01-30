import UIKit
import RealmSwift

final class SelectCreateViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBAction private func saveButton(_ sender: UIButton) {
        saveButtonisEnabled(text: contentTextView1.text)
        saveButtonisEnabled(text: contentTextView2.text)
        saveButtonisEnabled(text: contentTextView3.text)
        saveButtonisEnabled(text: contentTextView4.text)
        saveButtonisEnabled(text: contentTextView5.text)
        saveButtonisEnabled(text: answerTextView1.text)
        saveButtonisEnabled(text: answerTextView2.text)
        saveButtonisEnabled(text: answerTextView3.text)
        saveButtonisEnabled(text: answerTextView4.text)
        saveButtonisEnabled(text: answerTextView5.text)
        saveButtonisEnabled(text: choicesTextView1of1.text)
        saveButtonisEnabled(text: choicesTextView2of1.text)
        saveButtonisEnabled(text: choicesTextView3of1.text)
        saveButtonisEnabled(text: choicesTextView4of1.text)
        saveButtonisEnabled(text: choicesTextView1of2.text)
        saveButtonisEnabled(text: choicesTextView2of2.text)
        saveButtonisEnabled(text: choicesTextView3of2.text)
        saveButtonisEnabled(text: choicesTextView4of2.text)
        saveButtonisEnabled(text: choicesTextView1of3.text)
        saveButtonisEnabled(text: choicesTextView2of3.text)
        saveButtonisEnabled(text: choicesTextView3of3.text)
        saveButtonisEnabled(text: choicesTextView4of3.text)
        saveButtonisEnabled(text: choicesTextView1of4.text)
        saveButtonisEnabled(text: choicesTextView2of4.text)
        saveButtonisEnabled(text: choicesTextView3of4.text)
        saveButtonisEnabled(text: choicesTextView4of4.text)
        saveButtonisEnabled(text: choicesTextView1of5.text)
        saveButtonisEnabled(text: choicesTextView2of5.text)
        saveButtonisEnabled(text: choicesTextView3of5.text)
        saveButtonisEnabled(text: choicesTextView4of5.text)

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
    
    @IBOutlet private weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneButton()
        setupNotifications()
        
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
        answerTextView1.inputView = pickerView1
        answerTextView2.inputView = pickerView2
        answerTextView3.inputView = pickerView3
        answerTextView4.inputView = pickerView4
        answerTextView5.inputView = pickerView5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private let pickerView1 = UIPickerView()
    private let pickerView2 = UIPickerView()
    private let pickerView3 = UIPickerView()
    private let pickerView4 = UIPickerView()
    private let pickerView5 = UIPickerView()
    private var testDataList: [TestDataModel] = []
    private var testData = TestDataModel()
    private var list: [String] = ["", "1", "2", "3", "4"]
    private let versionNumber = 11
    private let toolbarWidthValue = 320
    private let toolbarHeightValue = 40
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: toolbarWidthValue, height: toolbarHeightValue))
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
        let config = Realm.Configuration(schemaVersion: UInt64(versionNumber))
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
    func saveButtonisEnabled(text: String) {
        if text.count != 0 && titleTextField.text != "" {
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

//解答をpickerViewに変更
extension SelectCreateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
            answerTextView1.text = list[row]
        } else if pickerView === pickerView2 {
            answerTextView2.text = list[row]
        } else if pickerView === pickerView3 {
            answerTextView3.text = list[row]
        } else if pickerView === pickerView4 {
            answerTextView4.text = list[row]
        } else if pickerView === pickerView5 {
            answerTextView5.text = list[row]
        }
    }
}
