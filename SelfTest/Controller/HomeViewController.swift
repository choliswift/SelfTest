import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    func configureButton() {
        selectButton.layer.cornerRadius = selectButton.bounds.width / 11
        createButton.layer.cornerRadius = createButton.bounds.width / 11
        modeButton.layer.cornerRadius = modeButton.bounds.width / 11
    }
    
}
