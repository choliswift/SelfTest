import UIKit
import RealmSwift

final class SentenceCreateViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var testContentTextField: UITextField!
    @IBOutlet private weak var answerTextField: UITextField!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBAction func deleteButton(_ sender: UIButton) {
    }
    @IBAction func addButton(_ sender: UIButton) {
    }
    @IBAction func saveButton(_ sender: UIButton) {
        saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneButton()
    }
    
    private(set) var testData = TestDataModel()
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }

    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        titleTextField.inputAccessoryView = toolBar
        testContentTextField.inputAccessoryView = toolBar
        answerTextField.inputAccessoryView = toolBar
    }
    
    func saveData() {
        let realm = try! Realm()
        try! realm.write {
            testData.title = titleTextField.text ?? ""
            realm.add(testData)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
