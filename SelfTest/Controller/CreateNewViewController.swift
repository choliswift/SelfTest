import UIKit
import RealmSwift

final class CreateNewViewController: UIViewController {
    @IBOutlet private weak var sentenceButton: UIButton!
    @IBOutlet private weak var choiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    func configureButton() {
        sentenceButton.layer.cornerRadius = sentenceButton.bounds.width / 11
        choiceButton.layer.cornerRadius = choiceButton.bounds.width / 11
    }
}

