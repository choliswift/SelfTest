import UIKit
import RealmSwift

final class CreateNewViewController: UIViewController {
    @IBOutlet private weak var fiveSentenceButton: UIButton!
    @IBOutlet private weak var selectTestButton: UIButton!
    @IBOutlet private weak var tenSentenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @IBAction private func fiveSentenceButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "FiveSentenceCreate", bundle: nil)
        guard let subView = storyboard.instantiateViewController(identifier: "FiveSentenceCreateViewController") as? FiveSentenceCreateViewController else { return }
        navigationController?.pushViewController(subView, animated: true)
    }
    
    @IBAction private func tenSentenceButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "TenSentenceCreate", bundle: nil)
        guard let subView = storyboard.instantiateViewController(identifier: "TenSentenceCreateViewController") as? TenSentenceCreateViewController else { return }
        navigationController?.pushViewController(subView, animated: true)
    }
    
    @IBAction private func selectTestButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "SelectCreate", bundle: nil)
        guard let subView = storyboard.instantiateViewController(identifier: "SelectCreateViewController") as? SelectCreateViewController else { return }
        navigationController?.pushViewController(subView, animated: true)
    }
    
    
    func configureButton() {
        fiveSentenceButton.layer.cornerRadius = fiveSentenceButton.bounds.width / 11
        tenSentenceButton.layer.cornerRadius = tenSentenceButton.bounds.width / 11
        selectTestButton.layer.cornerRadius = selectTestButton.bounds.width / 11
    }
}

