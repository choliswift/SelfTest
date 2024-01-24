import UIKit
import RealmSwift

final class HomeViewController: UIViewController {
    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var modeButton: UIButton!

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
