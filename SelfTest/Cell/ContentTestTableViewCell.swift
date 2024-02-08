import UIKit
import RealmSwift

protocol SentenceTableViewCellDelegate: AnyObject {
    //TextFieldの変更を通知するdelegateを作成
    func testContentTextFieldDidEditing(_ cell: ContentTestTableViewCell, didChangeValue value: String)
    func answerTextViewDidEditing(_ cell: ContentTestTableViewCell, didChangeValue value: String)
}

final class ContentTestTableViewCell: UITableViewCell {
    
    weak var delegate: SentenceTableViewCellDelegate?

    @IBOutlet weak var testContentTextField: UITextField!
    @IBOutlet weak var numberOfSentenceTextLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    func addSentenceNumber(update: String) {
        numberOfSentenceTextLabel.text = "第\(update)問"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //セル側で変更があった際に通知を送るようにdelegateにこのセル自体を代入
        testContentTextField.delegate = self
        answerTextView.delegate = self
        //textViewの見た目をtextFieldに合わせて調整
        answerTextView.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.2)
        answerTextView.layer.borderWidth = 1.0
        answerTextView.layer.cornerRadius = 6.0
        answerTextView.layer.masksToBounds = true
        //カスタムセル側のUIBarButtonはこっちで記述する
        setDoneButton()
    }
    //完了ボタンを押した時の処理
    @objc func tapDoneButton() {
        //UIViewController側だとview.endeditingでいいが、そうじゃない場合は以下のやり方でやる
        testContentTextField.resignFirstResponder()
        answerTextView.resignFirstResponder()
    }
    
    func setDoneButton() {
        //inputAccesoryViewに入れるtoolbar
        let toolbar = UIToolbar()
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        //toolbarのitemsに作成したスペースと完了ボタンを入れる。実際にも左から順に表示されます。
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        //作成したtoolbarをtextField,textViewのinputAccessoryViewに入れる
        testContentTextField.inputAccessoryView = toolbar
        answerTextView.inputAccessoryView = toolbar
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
        self.delegate?.testContentTextFieldDidEditing(self, didChangeValue: textField.text ?? "")
    }
}

extension ContentTestTableViewCell: UITextViewDelegate {
    //textViewの変更をコントローラー側に通知する
    //textViewDidChangeSelectionにすると、なぜかセルの再利用が行われてしまうので、didChangeにしてある
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.answerTextViewDidEditing(self, didChangeValue: textView.text ?? "")
    }
}
