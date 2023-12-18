import UIKit
import RealmSwift

class SelectTestViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
    }
    
    var testDataList: [TestDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTestData()
        tableView.reloadData()
    }
    
    func setTestData() {
        let realm = try! Realm()
        let result = realm.objects(TestDataModel.self)
        testDataList = Array(result)
    }
}

extension SelectTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as? TestTableViewCell {
            let testDataModel: TestDataModel = testDataList[indexPath.row]
            cell.update(testDataModel)
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension SelectTestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        if let sentenceEditViewController = storyborad.instantiateViewController(identifier: "SentenceEditViewController") as? SentenceEditViewController {
            let testData = testDataList[indexPath.row]
            sentenceEditViewController.configure(test: testData)
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(sentenceEditViewController, animated: true)
        }
    }
}

extension SelectTestViewController: TestTableViewCellDelegate {
    func testTableViewCellDidTapButton(cell: UITableViewCell) {
    }
    
    
}
