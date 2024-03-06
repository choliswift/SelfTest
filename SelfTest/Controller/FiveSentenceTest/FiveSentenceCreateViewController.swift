import UIKit
import RealmSwift

final class FiveSentenceCreateViewController:UIViewController {
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ContentTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTestTableViewCell")
        setDoneButton()
        setTestData()
        setupNotifications()
        
        //カスタムセルのキーボードを閉じる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        textIsEmpty()
    }
    
    
    private var testDataList: [TestDataModel] = []
    private var testDataModel = TestDataModel()
    private var testYobiDataModel = TestYobiDataModel()
    private var testContentData: [TestYobiDataModel] = []
    private var testAnswerData: [TestYobiDataModel] = []
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    func setDoneButton() {
        //inputAccesoryViewに入れるtoolbar
        let toolbar = UIToolbar()
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        //toolbarのitemsに作成したスペースと完了ボタンを入れる。実際にも左から順に表示されます。
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        titleTextField.inputAccessoryView = toolbar
    }
    
    func setTestData() {
        for _ in 1...5 {
            testDataList.append(testDataModel)
            //配列にない要素にアクセスしようとするとクラッシュするので、先に要素を追加しておく
            testContentData.append(testYobiDataModel)
            testAnswerData.append(testYobiDataModel)
        }
    }
    
    func saveData() { //保存する内容の書き方を修正する必要がある
        let config = Realm.Configuration(schemaVersion: UInt64(Constant.version))
        Realm.Configuration.defaultConfiguration = config
        
        //ここの保存処理方法を、通知を受けた最新のText内容を保存するように変更する必要がある。
        let realm = try! Realm()
        try! realm.write {
            testDataModel.title = titleTextField.text ?? ""
            testDataModel.testContent1 = testContentData[0].testYobiText
            testDataModel.testContent2 = testContentData[1].testYobiText
            testDataModel.testContent3 = testContentData[2].testYobiText
            testDataModel.testContent4 = testContentData[3].testYobiText
            testDataModel.testContent5 = testContentData[4].testYobiText
            testDataModel.testAnswer1 = testAnswerData[0].testYobiText
            testDataModel.testAnswer2 = testAnswerData[1].testYobiText
            testDataModel.testAnswer3 = testAnswerData[2].testYobiText
            testDataModel.testAnswer4 = testAnswerData[3].testYobiText
            testDataModel.testAnswer5 = testAnswerData[4].testYobiText
            testDataModel.kind = 3
            realm.add(testDataModel)
        }
        //保存したら一番最初の画面に戻るように処理
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func textIsEmpty() {
        for i in 0...4 {
            if testContentData[i].testYobiText.isEmpty {
                alertLabel.text = "空欄があります。入力してください。"
                alertLabel.textColor = .red
                return
            }
            if testAnswerData[i].testYobiText.isEmpty {
                alertLabel.text = "空欄があります。入力してください。"
                alertLabel.textColor = .red
                return
            }
            if titleTextField.text == "" {
                alertLabel.text = "空欄があります。入力してください。"
                alertLabel.textColor = .red
                return
            }
        }
        alertLabel.text = "OK"
        alertLabel.textColor = .blue
        saveData()
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
              //Outletで結びつけたtableViewのButtomをここで制約
              let tableViewButtomConstraint = self.tableViewBottom else { return }
        
        //キーボードの高さを読み込む
        let keyboardHeight = keyboardFrame.height
        //tableViewのButtomを再設定
        tableViewButtomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func keyboardWillClose(_ notification: Notification) {
        //キーボードのアニメーション時間を設定
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              //キーボードのアニメーションの曲線
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              //Outletで結びつけたtableViewのButtomをここで制約
              let tableViewButtomConstraint = self.tableViewBottom else { return }
        
        //tableViewのButtomを再設定
        tableViewButtomConstraint.constant = 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension FiveSentenceCreateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTestTableViewCell", for: indexPath) as? ContentTestTableViewCell else { return UITableViewCell() }
        cell.testContentTextField.text = nil
        cell.answerTextView.text = nil
        
        cell.testContentTextField.text = testContentData[indexPath.row].testYobiText
        cell.answerTextView.text = testAnswerData[indexPath.row].testYobiText
        
        cell.addSentenceNumber(update: "\(indexPath.row + 1)")
        cell.delegate = self
        return cell
    }
}

extension FiveSentenceCreateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FiveSentenceCreateViewController: SentenceTableViewCellDelegate {
    func testContentTextFieldDidEditing(_ cell: ContentTestTableViewCell, didChangeValue contentvalue: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testContentData.append(TestYobiDataModel(testYobiText: contentvalue))
        testContentData[testNumber ?? 0] = TestYobiDataModel(testYobiText: contentvalue)
    }
    
    func answerTextViewDidEditing(_ cell: ContentTestTableViewCell, didChangeValue answervalue: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testAnswerData.append(TestYobiDataModel(testYobiText: answervalue))
        testAnswerData[testNumber ?? 0] = TestYobiDataModel(testYobiText: answervalue)
    }
    
    
}
