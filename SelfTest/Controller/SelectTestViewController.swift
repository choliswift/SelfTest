import UIKit
import RealmSwift

final class SelectTestViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TableViewの編集モードを使用せずに、セルの順番を変えれるように処理
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
    }
    
    private(set) var testDataList: [TestDataModel] = []
    //保存した内容をセルに表示する処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTestData()
        tableView.reloadData() //これはdidloadではなく、こちらに記述。これがないと修正が反映されない。
    }

    func setTestData() {
        let config = Realm.Configuration(schemaVersion: UInt64(Constant.version))
        Realm.Configuration.defaultConfiguration = config
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
            
            //テストの種類を判別
            let kindTest = testDataList[indexPath.row].kind
            if kindTest == 1 {
                cell.testKindsLabel.text = "入力式問題"
            } else if kindTest == 2 {
                cell.testKindsLabel.text = "選択式問題"
            }
            //削除ボタンをセル内で押せるようにaddTarget方式で追加
            let deleteButton = cell.deleteButton
            deleteButton?.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
            //編集ボタンをセル内で押せるようにaddTarget方式で追加
            let editButton = cell.editButton
            editButton?.addTarget(self, action: #selector(editCell), for: .touchUpInside)
            
            let testDataModel: TestDataModel = testDataList[indexPath.row]
            cell.update(testDataModel)
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    //セルの順番を変えれるように処理
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //入れ替えた後にセルをどうするのかの処理を記述。
        let selectCell = testDataList[sourceIndexPath.row]
        guard let indexPath = testDataList.firstIndex(of: selectCell) else { return }
        testDataList.remove(at: indexPath)
        testDataList.insert(selectCell, at: destinationIndexPath.row)
    }
}

extension SelectTestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルタップ時にアラートを表示
        let alert = UIAlertController(title: "問題を開始しますか？", message: "", preferredStyle: UIAlertController.Style.alert)
        let start = UIAlertAction(title: "はい", style: .destructive) { _ in
            
            let kindTest = self.testDataList[indexPath.row].kind
            if kindTest == 1 {
                //ここに、問題開始画面へ遷移する処理を記述。kindが１だったら入力問題へ。０だったら選択問題へ。
                //文章入力問題
                let storyboard: UIStoryboard = UIStoryboard(name: "StartTest", bundle: nil)
                //ここはinstantiateInitialViewController()ではStartViewにデータ譲渡ができない。この記述方法にしないと、だめ。
                if let vc = storyboard.instantiateViewController(identifier: "StartViewController") as? StartViewController {
                    let testData = self.testDataList[indexPath.row]
                    vc.configure(test: testData)
                    self.present(vc, animated: true, completion: nil)
                    //追記。storyBoardのpresentationで「FullScrean」を押して、全画面表示にすることにより、テスト中に戻れないようにする。途中中断ボタンを用意する。
                }
            } else if kindTest == 2 {
                //選択式問題
                let storyboard: UIStoryboard = UIStoryboard(name: "StartSelectTest", bundle: nil)
                if let vc = storyboard.instantiateViewController(identifier: "StartSelectTestViewController") as? StartSelectTestViewController {
                    let testData = self.testDataList[indexPath.row]
                    vc.configure(test: testData)
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        let close = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        
        //実行順に左から並ぶ
        alert.addAction(close)
        alert.addAction(start)
        present(alert, animated: true, completion: nil)
        //タップしたセルを解除する処理は、ここに書く必要がある
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //セルの順番を変えれるように処理
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension SelectTestViewController: TestTableViewCellDelegate {
    @objc func editCell(_ cell: UITableViewCell) {
        //TableViewのセルに当てられたindexPath番号を呼び出してその番号を削除するように処理
        var superview = cell.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        //いつもならdelegateで記述していた処理を、セルのボタンタップ時に行うように修正
        let kindTest = self.testDataList[indexPath.row].kind
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if kindTest == 1 {
            if let sentenceEditViewController = storyboard.instantiateViewController(identifier: "NewSentenceEditViewController") as? NewSentenceEditViewController {
                let testData = testDataList[indexPath.row]
                sentenceEditViewController.configure(test: testData)
                navigationController?.pushViewController(sentenceEditViewController, animated: true)
            }
        } else if kindTest == 2 {
            if let selectEditViewController = storyboard.instantiateViewController(identifier: "NewSelectEditViewController") as? NewSelectEditViewController {
                let testData = testDataList[indexPath.row]
                selectEditViewController.configure(test: testData)
                navigationController?.pushViewController(selectEditViewController, animated: true)
            }
        }
    }
    
    @objc func deleteCell(_ cell: UITableViewCell) {
        //TableViewのセルに当てられたindexPath番号を呼び出してその番号を削除するように処理
        var superview = cell.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        //削除ボタンを押した際にアラート画面を表示
        let alert = UIAlertController(title: "問題を削除しますか？", message: "", preferredStyle: UIAlertController.Style.alert)
        let start = UIAlertAction(title: "はい", style: .destructive) { (action) in
            //Realmから削除する処理。これがないと、画面遷移した際に削除したセルが復活する
            let targetTest = self.testDataList[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(targetTest)
            }
            //TableViewのデータを削除する処理
            self.testDataList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let close = UIAlertAction(title: "いいえ", style: .default, handler: nil)

        alert.addAction(close)
        alert.addAction(start)
        present(alert, animated: true, completion: nil)
    }
}


