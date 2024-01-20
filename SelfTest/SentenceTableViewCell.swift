import UIKit
import RealmSwift

protocol SentenceTableViewCellDelegate: AnyObject {
    func deleteCell(_ cell: UITableViewCell)
    //TextFieldの変更を通知するdelegateを作成
    func textFieldDidEndEditing(cell: SentenceTableViewCell, value: String)
}

class SentenceTableViewCell: UITableViewCell {
    
    weak var delegate: SentenceTableViewCellDelegate?

    @IBOutlet weak var testContentTextField: UITextField!
    @IBOutlet weak var numberOfSentenceTextLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.deleteCell(self)
    }
    
    //再利用可能なセルを再利用した際にどう扱うかを設定
    override func prepareForReuse() {
        super.prepareForReuse()
        testContentTextField.text = .none
        answerTextView.text = .none
    }
    
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

extension SentenceTableViewCell: UITextFieldDelegate {
    //キーボードのreturnを推した際に、テキストフィールドの値をどうするかという処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textFieldの変更をコントローラー側に通知する
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
}

extension SentenceTableViewCell: UITextViewDelegate {
    //textViewの変更をコントローラー側に通知する
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.textFieldDidEndEditing(cell: self, value: textView.text!)
    }
}
