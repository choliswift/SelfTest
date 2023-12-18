import UIKit
import RealmSwift

class CreateNewViewController: UIViewController {
    @IBOutlet weak var sentenceButton: UIButton!
    @IBOutlet weak var wordButton: UIButton!
    @IBOutlet weak var choiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    func configureButton() {
        sentenceButton.layer.cornerRadius = sentenceButton.bounds.width / 11
        wordButton.layer.cornerRadius = wordButton.bounds.width / 11
        choiceButton.layer.cornerRadius = choiceButton.bounds.width / 11
    }
    
}

