import UIKit
import RealmSwift

class SentenceEditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var testData = TestDataModel()
    
    func configure(test: TestDataModel) {
        testData.id = test.id
        testData.title = test.title
        testData.number = test.number
    }
    
    func displayData() {
    }
    //表示自体は後続のPRで対応予定
}
