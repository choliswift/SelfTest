import UIKit
import RealmSwift

final class ResultSelectTestViewController: UIViewController {
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var evaluationLabel: UILabel!
    @IBOutlet private weak var viewCloseButon: UIButton!
    @IBAction private func viewCloseButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    dynamic var correct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(correct)"
        evaluationText()
    }
    
    func evaluationText() {
        switch correct {
        case 1:
            evaluationLabel.text = "難しかったかな？"
        case 2:
            evaluationLabel.text = "まだ課題がたくさん！"
        case 3:
            evaluationLabel.text = "もう一息だね！"
        case 4:
            evaluationLabel.text = "あと1問！"
        case 5:
            evaluationLabel.text = "全問正解！"
            scoreLabel.textColor = .red
        default:
            evaluationLabel.text = "まだまだだね。もっと頑張ろう！"
        }
    }
}
