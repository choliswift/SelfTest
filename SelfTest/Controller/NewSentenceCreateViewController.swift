import UIKit
import RealmSwift

final class SentenceNewViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        saveData()
    }
    @IBOutlet weak var arertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTestData()
        tableView.register(UINib(nibName: "ContentTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTestTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        setDoneButton()
        
        //カスタムセルのキーボードを閉じる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDoneButton))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        titleTextField.inputAccessoryView = toolBar
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
            testDataModel.testAnswer1 = testAnswerData[0].testYobiText
            testDataModel.testAnswer2 = testAnswerData[1].testYobiText
            testDataModel.kind = 1
            realm.add(testDataModel)
        }
        //保存したら一番最初の画面に戻るように処理
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setTestData() {
        for _ in 1...10 {
            testDataList.append(testDataModel)
            //配列にない要素にアクセスしようとするとクラッシュするので、先に要素を追加しておく
            testContentData.append(testYobiDataModel)
            testAnswerData.append(testYobiDataModel)
        }
    }
}

extension SentenceNewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTestTableViewCell", for: indexPath) as? ContentTestTableViewCell {
            //let testModel: TestDataModel = testDataList[indexPath.row]
            //第⚪︎問の数字がセルが増えるごとにセルに合わせて増えるように処理。修正が必要。
            cell.addSentenceNumber(update: "\(indexPath.row + 1)")
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension SentenceNewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("タップしたindexpathは\(indexPath.row)です")
    }
}

extension SentenceNewViewController: SentenceTableViewCellDelegate {
    //cellに配置したtextFieldの変更の通知を受け取る
    func textFieldEditing(cell: ContentTestTableViewCell, value contentvalue: String) {
        let path = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = path?.row
        testContentData.append(TestYobiDataModel(testYobiText: contentvalue))
        testContentData[testNumber!] = TestYobiDataModel(testYobiText: contentvalue)

        //入力内容を終わった際に確認
        NSLog("row = %d, contentvalue = %@", path!.row, contentvalue)
    }
    //cellに配置したtextViewの変更の通知を受け取る
    func textViewEditing(cell: ContentTestTableViewCell, value answervalue: String) {
        let path = tableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: tableView))
        let testNumber = path?.row
        testAnswerData.append(TestYobiDataModel(testYobiText: answervalue))
        testAnswerData[testNumber!] = TestYobiDataModel(testYobiText: answervalue)
        NSLog("row = %d, answervalue = %@", path!.row, answervalue)
    }
}
