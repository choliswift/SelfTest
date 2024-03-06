import UIKit
import RealmSwift

final class ResultViewController: UIViewController {
    
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
        case 1...3:
            evaluationLabel.text = "難しかったかな？"
        case 4...6:
            evaluationLabel.text = "まだ課題がたくさん！"
        case 7...9:
            evaluationLabel.text = "もう一息だね！"
        case 10:
            evaluationLabel.text = "10問も問題を作って全問正解は偉い！"
            scoreLabel.textColor = .red
        default:
            evaluationLabel.text = "まだまだだね。もっと頑張ろう！"
        }
    }
}
