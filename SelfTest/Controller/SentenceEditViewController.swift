import UIKit
import RealmSwift

final class SentenceEditViewController: UIViewController {
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
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBAction private func savaButton(_ sender: UIButton) {
        saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
    }
    
    var testData = TestDataModel()
    
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
}
