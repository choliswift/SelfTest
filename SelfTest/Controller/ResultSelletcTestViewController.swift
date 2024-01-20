import UIKit
import RealmSwift

class ResultSelletcTestViewController: UIViewController {
    
    @IBOutlet weak var viewCloseButon: UIButton!
    
    @IBAction func viewCloseButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
