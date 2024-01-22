import UIKit
import RealmSwift

final class StartSellectTestViewController: UIViewController {
    
    @IBOutlet private weak var testCount: UILabel!
    @IBOutlet private weak var ContentLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!

    @IBAction private func nextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
