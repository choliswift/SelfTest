import UIKit
import RealmSwift

protocol SentenceTableViewCellDelegate: AnyObject {
    //TextFieldの変更を通知するdelegateを作成
    func textFieldDidEndEditing(cell: ContentTestTableViewCell, value: String)
    func textViewDidEndEditing(cell: ContentTestTableViewCell, value: String)
}

class ContentTestTableViewCell: UITableViewCell {
    
    weak var delegate: SentenceTableViewCellDelegate?

    @IBOutlet weak var testContentTextField: UITextField!
    @IBOutlet weak var numberOfSentenceTextLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    func addSentenceNumber(update: String) {
        numberOfSentenceTextLabel.text = "第\(update)問"
    }

    //セル側で変更があった際に通知を送るようにdelegateにこのセル自体を代入
    override func awakeFromNib() {
        super.awakeFromNib()
        testContentTextField.delegate = self
        answerTextView.delegate = self
        answerTextView.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.2)
        answerTextView.layer.borderWidth = 1.0
        answerTextView.layer.cornerRadius = 6.0
        answerTextView.layer.masksToBounds = true
    }
}

extension ContentTestTableViewCell: UITextFieldDelegate {
    //キーボードのreturnを推した際に、テキストフィールドの値をどうするかという処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textFieldの変更をコントローラー側に通知する
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.delegate?.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
}

extension ContentTestTableViewCell: UITextViewDelegate {
    //textViewの変更をコントローラー側に通知する
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.textViewDidEndEditing(cell: self, value: textView.text!)
    }
}
