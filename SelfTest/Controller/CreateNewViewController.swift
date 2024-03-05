import UIKit
import RealmSwift

final class CreateNewViewController: UIViewController {
    @IBOutlet private weak var fiveSentenceButton: UIButton!
    @IBOutlet private weak var choiceButton: UIButton!
    @IBOutlet private weak var tenSentenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @IBAction func fiveSentenceButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CreateFiveSentenceTest", bundle: nil)
        guard let subView = storyboard.instantiateViewController(identifier: "FiveSentenceCreateViewController") as? FiveSentenceCreateViewController else { return }
        navigationController?.pushViewController(subView, animated: true)
        //self.present(subView, animated: true, completion: nil)
    }
    
    func configureButton() {
        fiveSentenceButton.layer.cornerRadius = fiveSentenceButton.bounds.width / 11
        tenSentenceButton.layer.cornerRadius = tenSentenceButton.bounds.width / 11
        choiceButton.layer.cornerRadius = choiceButton.bounds.width / 11
    }
}

