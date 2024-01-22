import UIKit
import RealmSwift

final class ResultSelletcTestViewController: UIViewController {
    
    @IBOutlet private weak var viewCloseButon: UIButton!
    
    @IBAction private func viewCloseButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
