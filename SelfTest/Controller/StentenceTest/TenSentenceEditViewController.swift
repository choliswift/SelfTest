import UIKit
import RealmSwift

final class TenSentenceEditViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBAction private func savaButton(_ sender: UIButton) {
        textIsEmpty()
    }
    @IBOutlet private weak var tableViewBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ContentTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTestTableViewCell")
        
        setDoneButton()
        setTestData()
        displayData()
        setupNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private var testDataList: [TestDataModel] = []
    private var testDataModel = TestDataModel()
    private var testYobiDataModel = TestYobiDataModel()
    private var testContentData: [TestYobiDataModel] = []
    private var testAnswerData: [TestYobiDataModel] = []
    
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
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }

    func configure(test: TestDataModel) {
        testDataModel.id = test.id
        testDataModel.title = test.title
        testDataModel.testContent1 = test.testContent1
        testDataModel.testContent2 = test.testContent2
        testDataModel.testContent3 = test.testContent3
        testDataModel.testContent4 = test.testContent4
        testDataModel.testContent5 = test.testContent5
        testDataModel.testContent6 = test.testContent6
        testDataModel.testContent7 = test.testContent7
        testDataModel.testContent8 = test.testContent8
        testDataModel.testContent9 = test.testContent9
        testDataModel.testContent10 = test.testContent10
        testDataModel.testAnswer1 = test.testAnswer1
        testDataModel.testAnswer2 = test.testAnswer2
        testDataModel.testAnswer3 = test.testAnswer3
        testDataModel.testAnswer4 = test.testAnswer4
        testDataModel.testAnswer5 = test.testAnswer5
        testDataModel.testAnswer6 = test.testAnswer6
        testDataModel.testAnswer7 = test.testAnswer7
        testDataModel.testAnswer8 = test.testAnswer8
        testDataModel.testAnswer9 = test.testAnswer9
        testDataModel.testAnswer10 = test.testAnswer10
    }
    
    func displayData() {
        titleTextField.text = testDataModel.title
        testContentData[0].testYobiText = testDataModel.testContent1
        testContentData[1].testYobiText = testDataModel.testContent2
        testContentData[2].testYobiText = testDataModel.testContent3
        testContentData[3].testYobiText = testDataModel.testContent4
        testContentData[4].testYobiText = testDataModel.testContent5
        testContentData[5].testYobiText = testDataModel.testContent6
        testContentData[6].testYobiText = testDataModel.testContent7
        testContentData[7].testYobiText = testDataModel.testContent8
        testContentData[8].testYobiText = testDataModel.testContent9
        testContentData[9].testYobiText = testDataModel.testContent10
        testAnswerData[0].testYobiText = testDataModel.testAnswer1
        testAnswerData[1].testYobiText = testDataModel.testAnswer2
        testAnswerData[2].testYobiText = testDataModel.testAnswer3
        testAnswerData[3].testYobiText = testDataModel.testAnswer4
        testAnswerData[4].testYobiText = testDataModel.testAnswer5
        testAnswerData[5].testYobiText = testDataModel.testAnswer6
        testAnswerData[6].testYobiText = testDataModel.testAnswer7
        testAnswerData[7].testYobiText = testDataModel.testAnswer8
        testAnswerData[8].testYobiText = testDataModel.testAnswer9
        testAnswerData[9].testYobiText = testDataModel.testAnswer10
    }
    
    func saveData() {
        let realm = try! Realm()
            if let editedTest = realm.object(ofType: TestDataModel.self, forPrimaryKey: testDataModel.id) {
                try! realm.write {
                    editedTest.title = titleTextField.text ?? ""
                    editedTest.testContent1 = testContentData[0].testYobiText
                    editedTest.testContent2 = testContentData[1].testYobiText
                    editedTest.testContent3 = testContentData[2].testYobiText
                    editedTest.testContent4 = testContentData[3].testYobiText
                    editedTest.testContent5 = testContentData[4].testYobiText
                    editedTest.testContent6 = testContentData[5].testYobiText
                    editedTest.testContent7 = testContentData[6].testYobiText
                    editedTest.testContent8 = testContentData[7].testYobiText
                    editedTest.testContent9 = testContentData[8].testYobiText
                    editedTest.testContent10 = testContentData[9].testYobiText
                    editedTest.testAnswer1 = testAnswerData[0].testYobiText
                    editedTest.testAnswer2 = testAnswerData[1].testYobiText
                    editedTest.testAnswer3 = testAnswerData[2].testYobiText
                    editedTest.testAnswer4 = testAnswerData[3].testYobiText
                    editedTest.testAnswer5 = testAnswerData[4].testYobiText
                    editedTest.testAnswer6 = testAnswerData[5].testYobiText
                    editedTest.testAnswer7 = testAnswerData[6].testYobiText
                    editedTest.testAnswer8 = testAnswerData[7].testYobiText
                    editedTest.testAnswer9 = testAnswerData[8].testYobiText
                    editedTest.testAnswer10 = testAnswerData[9].testYobiText
                    realm.add(editedTest, update: .modified)
                }
            }
        self.navigationController?.popViewController(animated: true)
    }
    
    //未入力があった際に保存できないようにする
    func textIsEmpty() {
        for i in 0..<testDataList.count {
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
    
    func setTestData() {
        for _ in 1...10 {
            testDataList.append(testDataModel)
            //配列にない要素にアクセスしようとするとクラッシュするので、先に要素を追加しておく
            testContentData.append(testYobiDataModel)
            testAnswerData.append(testYobiDataModel)
        }
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

extension TenSentenceEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTestTableViewCell", for: indexPath) as? ContentTestTableViewCell else { return UITableViewCell()}
        cell.testContentTextField.text = nil
        cell.answerTextView.text = nil
        
        cell.testContentTextField.text = testContentData[indexPath.row].testYobiText
        cell.answerTextView.text = testAnswerData[indexPath.row].testYobiText
        
        //第⚪︎問の数字がセルが増えるごとにセルに合わせて増えるように処理。修正が必要。
        cell.addSentenceNumber(update: "\(indexPath.row + 1)")
        cell.delegate = self
        return cell
    }
}

extension TenSentenceEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("タップしたindexpathは\(indexPath.row)です")
    }
}

extension TenSentenceEditViewController: SentenceTableViewCellDelegate {
    //cellに配置したtextFieldの変更の通知を受け取る
    func testContentTextFieldDidEditing(_ cell: ContentTestTableViewCell, didChangeValue contentvalue: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testContentData.append(TestYobiDataModel(testYobiText: contentvalue))
        testContentData[testNumber ?? 0] = TestYobiDataModel(testYobiText: contentvalue)
    }
    //cellに配置したtextViewの変更の通知を受け取る
    func answerTextViewDidEditing(_ cell: ContentTestTableViewCell, didChangeValue answervalue: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testAnswerData.append(TestYobiDataModel(testYobiText: answervalue))
        testAnswerData[testNumber ?? 0] = TestYobiDataModel(testYobiText: answervalue)
    }
}
