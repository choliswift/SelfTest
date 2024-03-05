import UIKit
import RealmSwift

final class NewSelectEditViewController: UIViewController {
    @IBOutlet private weak var titleEditTextField: UITextField!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBAction private func savaButton(_ sender: UIButton) {
        textIsEmpty()
    }
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ここ順番間違えないように
        setTestData()
        displayData()
        setDoneButton()
        setupNotifications()
        tableView.register(UINib(nibName: "SelectTestTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectTestTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private var testDataList: [TestDataModel] = []
    private var testDataModel = TestDataModel()
    private var testYobiDataModel = TestYobiDataModel()
    private var testContentData: [TestYobiDataModel] = []
    private var testChoiceData1: [TestYobiDataModel] = []
    private var testChoiceData2: [TestYobiDataModel] = []
    private var testChoiceData3: [TestYobiDataModel] = []
    private var testChoiceData4: [TestYobiDataModel] = []
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
        titleEditTextField.inputAccessoryView = toolbar
    }

    func configure(test: TestDataModel) {
        testDataModel.id = test.id
        testDataModel.title = test.title
        testDataModel.testContent1 = test.testContent1
        testDataModel.testContent2 = test.testContent2
        testDataModel.testContent3 = test.testContent3
        testDataModel.testContent4 = test.testContent4
        testDataModel.testContent5 = test.testContent5
        testDataModel.choices1of1 = test.choices1of1
        testDataModel.choices2of1 = test.choices2of1
        testDataModel.choices3of1 = test.choices3of1
        testDataModel.choices4of1 = test.choices4of1
        testDataModel.choices1of2 = test.choices1of2
        testDataModel.choices2of2 = test.choices2of2
        testDataModel.choices3of2 = test.choices3of2
        testDataModel.choices4of2 = test.choices4of2
        testDataModel.choices1of3 = test.choices1of3
        testDataModel.choices2of3 = test.choices2of3
        testDataModel.choices3of3 = test.choices3of3
        testDataModel.choices4of3 = test.choices4of3
        testDataModel.choices1of4 = test.choices1of4
        testDataModel.choices2of4 = test.choices2of4
        testDataModel.choices3of4 = test.choices3of4
        testDataModel.choices4of4 = test.choices4of4
        testDataModel.choices1of5 = test.choices1of5
        testDataModel.choices2of5 = test.choices2of5
        testDataModel.choices3of5 = test.choices3of5
        testDataModel.choices4of5 = test.choices4of5
        testDataModel.testAnswer1 = test.testAnswer1
        testDataModel.testAnswer2 = test.testAnswer2
        testDataModel.testAnswer3 = test.testAnswer3
        testDataModel.testAnswer4 = test.testAnswer4
        testDataModel.testAnswer5 = test.testAnswer5
    }
    
    func displayData() {
        titleEditTextField.text = testDataModel.title
        testContentData[0].testYobiText = testDataModel.testContent1
        testContentData[1].testYobiText = testDataModel.testContent2
        testContentData[2].testYobiText = testDataModel.testContent3
        testContentData[3].testYobiText = testDataModel.testContent4
        testContentData[4].testYobiText = testDataModel.testContent5
        testChoiceData1[0].testYobiText = testDataModel.choices1of1
        testChoiceData2[0].testYobiText = testDataModel.choices2of1
        testChoiceData3[0].testYobiText = testDataModel.choices3of1
        testChoiceData4[0].testYobiText = testDataModel.choices4of1
        testChoiceData1[1].testYobiText = testDataModel.choices1of2
        testChoiceData2[1].testYobiText = testDataModel.choices2of2
        testChoiceData3[1].testYobiText = testDataModel.choices3of2
        testChoiceData4[1].testYobiText = testDataModel.choices4of2
        testChoiceData1[2].testYobiText = testDataModel.choices1of3
        testChoiceData2[2].testYobiText = testDataModel.choices2of3
        testChoiceData3[2].testYobiText = testDataModel.choices3of3
        testChoiceData4[2].testYobiText = testDataModel.choices4of3
        testChoiceData1[3].testYobiText = testDataModel.choices1of4
        testChoiceData2[3].testYobiText = testDataModel.choices2of4
        testChoiceData3[3].testYobiText = testDataModel.choices3of4
        testChoiceData4[3].testYobiText = testDataModel.choices4of4
        testChoiceData1[4].testYobiText = testDataModel.choices1of5
        testChoiceData2[4].testYobiText = testDataModel.choices2of5
        testChoiceData3[4].testYobiText = testDataModel.choices3of5
        testChoiceData4[4].testYobiText = testDataModel.choices4of5
        testAnswerData[0].testYobiText = testDataModel.testAnswer1
        testAnswerData[1].testYobiText = testDataModel.testAnswer2
        testAnswerData[2].testYobiText = testDataModel.testAnswer3
        testAnswerData[3].testYobiText = testDataModel.testAnswer4
        testAnswerData[4].testYobiText = testDataModel.testAnswer5
    }
    
    func saveData() {
        let realm = try! Realm()
            if let editedTest = realm.object(ofType: TestDataModel.self, forPrimaryKey: testDataModel.id) {
                try! realm.write {
                    editedTest.title = titleEditTextField.text ?? ""
                    editedTest.testContent1 = testContentData[0].testYobiText
                    editedTest.testContent2 = testContentData[1].testYobiText
                    editedTest.testContent3 = testContentData[2].testYobiText
                    editedTest.testContent4 = testContentData[3].testYobiText
                    editedTest.testContent5 = testContentData[4].testYobiText
                    editedTest.testAnswer1 = testAnswerData[0].testYobiText
                    editedTest.testAnswer2 = testAnswerData[1].testYobiText
                    editedTest.testAnswer3 = testAnswerData[2].testYobiText
                    editedTest.testAnswer4 = testAnswerData[3].testYobiText
                    editedTest.testAnswer5 = testAnswerData[4].testYobiText
                    editedTest.choices1of1 = testChoiceData1[0].testYobiText
                    editedTest.choices2of1 = testChoiceData2[0].testYobiText
                    editedTest.choices3of1 = testChoiceData3[0].testYobiText
                    editedTest.choices4of1 = testChoiceData4[0].testYobiText
                    editedTest.choices1of2 = testChoiceData1[1].testYobiText
                    editedTest.choices2of2 = testChoiceData2[1].testYobiText
                    editedTest.choices3of2 = testChoiceData3[1].testYobiText
                    editedTest.choices4of2 = testChoiceData4[1].testYobiText
                    editedTest.choices1of3 = testChoiceData1[2].testYobiText
                    editedTest.choices2of3 = testChoiceData2[2].testYobiText
                    editedTest.choices3of3 = testChoiceData3[2].testYobiText
                    editedTest.choices4of3 = testChoiceData4[2].testYobiText
                    editedTest.choices1of4 = testChoiceData1[3].testYobiText
                    editedTest.choices2of4 = testChoiceData2[3].testYobiText
                    editedTest.choices3of4 = testChoiceData3[3].testYobiText
                    editedTest.choices4of4 = testChoiceData4[3].testYobiText
                    editedTest.choices1of5 = testChoiceData1[4].testYobiText
                    editedTest.choices2of5 = testChoiceData2[4].testYobiText
                    editedTest.choices3of5 = testChoiceData3[4].testYobiText
                    editedTest.choices4of5 = testChoiceData4[4].testYobiText
                    realm.add(editedTest, update: .modified)
                }
            }
        self.navigationController?.popViewController(animated: true)
    }
    
    //未入力があった際に保存できないようにする
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
            if titleEditTextField.text == "" {
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
        for _ in 1...5 {
            testDataList.append(testDataModel)
            //配列にない要素にアクセスしようとするとクラッシュするので、先に要素を追加しておく
            testContentData.append(testYobiDataModel)
            testChoiceData1.append(testYobiDataModel)
            testChoiceData2.append(testYobiDataModel)
            testChoiceData3.append(testYobiDataModel)
            testChoiceData4.append(testYobiDataModel)
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

extension NewSelectEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectTestTableViewCell", for: indexPath) as? SelectTestTableViewCell else { return UITableViewCell()}
        //cellを初期化する処理。
        cell.contentTextField.text = nil
        cell.choiceTextField1.text = nil
        cell.choiceTextField2.text = nil
        cell.choiceTextField3.text = nil
        cell.choiceTextField4.text = nil
        cell.answerTextField.text = nil
        
        //cellに入力した値を随時代入していく処理
        cell.contentTextField.text = testContentData[indexPath.row].testYobiText
        cell.choiceTextField1.text = testChoiceData1[indexPath.row].testYobiText
        cell.choiceTextField2.text = testChoiceData2[indexPath.row].testYobiText
        cell.choiceTextField3.text = testChoiceData3[indexPath.row].testYobiText
        cell.choiceTextField4.text = testChoiceData4[indexPath.row].testYobiText
        cell.answerTextField.text = testAnswerData[indexPath.row].testYobiText
        
        //第⚪︎問の数字がセルが増えるごとにセルに合わせて増えるように処理。修正が必要。
        cell.addSentenceNumber(update: "\(indexPath.row + 1)")
        cell.delegate = self
        return cell
    }
}

extension NewSelectEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("タップしたindexpathは\(indexPath.row)です")
    }
}

extension NewSelectEditViewController: SelectTableViewCellDelegate {
    func contentTextFieldDidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testContentData.append(TestYobiDataModel(testYobiText: value))
        testContentData[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
    
    func choiceTextField1DidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testChoiceData1.append(TestYobiDataModel(testYobiText: value))
        testChoiceData1[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
    
    func choiceTextField2DidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testChoiceData2.append(TestYobiDataModel(testYobiText: value))
        testChoiceData2[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
    
    func choiceTextField3DidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testChoiceData3.append(TestYobiDataModel(testYobiText: value))
        testChoiceData3[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
    
    func choiceTextField4DidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testChoiceData4.append(TestYobiDataModel(testYobiText: value))
        testChoiceData4[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
    
    func answerTextFieldDidEditing(_ cell: SelectTestTableViewCell, didChangeValue value: String) {
        let indexPath = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = indexPath?.row
        testAnswerData.append(TestYobiDataModel(testYobiText: value))
        testAnswerData[testNumber ?? 0] = TestYobiDataModel(testYobiText: value)
    }
}
