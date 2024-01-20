import UIKit
import RealmSwift

class StartSellectTestViewController: UIViewController {
    
    @IBOutlet weak var testCount: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    @IBAction func nextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
