import UIKit
import RealmSwift

protocol SelectTableViewCellDelegate: AnyObject {
    //TextFieldの変更を通知するdelegateを作成
    //それぞれに通知する関数を作ってあげることで、値が同じになるエラーを防ぐ
    func ContentTextFieldEditing(cell: SelectTestTableViewCell, value: String)
    func choiceTextField1Editing(cell: SelectTestTableViewCell, value: String)
    func choiceTextField2Editing(cell: SelectTestTableViewCell, value: String)
    func choiceTextField3Editing(cell: SelectTestTableViewCell, value: String)
    func choiceTextField4Editing(cell: SelectTestTableViewCell, value: String)
    func answerTextFieldEditing(cell: SelectTestTableViewCell, value: String)
}

class SelectTestTableViewCell: UITableViewCell {
    
    weak var delegate: SelectTableViewCellDelegate?

    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var choiceTextField1: UITextField!
    @IBOutlet weak var choiceTextField2: UITextField!
    @IBOutlet weak var choiceTextField3: UITextField!
    @IBOutlet weak var choiceTextField4: UITextField!
    @IBOutlet weak var numberOfSentenceTextLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    private let pickerView = UIPickerView()
    private var list: [String] = ["", "1", "2", "3", "4"]
    
    func addSentenceNumber(update: String) {
        numberOfSentenceTextLabel.text = "第\(update)問"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //セル側で変更があった際に通知を送るようにdelegateにこのセル自体を代入
        contentTextField.delegate = self
        choiceTextField1.delegate = self
        choiceTextField2.delegate = self
        choiceTextField3.delegate = self
        choiceTextField4.delegate = self
        answerTextField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        answerTextField.inputView = pickerView

        //カスタムセル側のUIBarButtonはこっちで記述する
        setDoneButton()
    }
    //完了ボタンを押した時の処理
    @objc func tapDoneButton() {
        //UIViewController側だとview.endeditingでいいが、そうじゃない場合は以下のやり方でやる
        contentTextField.resignFirstResponder()
        choiceTextField1.resignFirstResponder()
        choiceTextField2.resignFirstResponder()
        choiceTextField3.resignFirstResponder()
        choiceTextField4.resignFirstResponder()
        answerTextField.resignFirstResponder()
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
        contentTextField.inputAccessoryView = toolbar
        choiceTextField1.inputAccessoryView = toolbar
        choiceTextField2.inputAccessoryView = toolbar
        choiceTextField3.inputAccessoryView = toolbar
        choiceTextField4.inputAccessoryView = toolbar
        answerTextField.inputAccessoryView = toolbar
    }
}

extension SelectTestTableViewCell: UITextFieldDelegate {
    //キーボードのreturnを推した際に、テキストフィールドの値をどうするかという処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textFieldの変更をコントローラー側に通知する
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //それぞれに通知する関数を作ってあげることで、値が同じになるエラーを防ぐ
        self.delegate?.ContentTextFieldEditing(cell: self, value: contentTextField.text!)
        self.delegate?.choiceTextField1Editing(cell: self, value: choiceTextField1.text!)
        self.delegate?.choiceTextField2Editing(cell: self, value: choiceTextField2.text!)
        self.delegate?.choiceTextField3Editing(cell: self, value: choiceTextField3.text!)
        self.delegate?.choiceTextField4Editing(cell: self, value: choiceTextField4.text!)
        self.delegate?.answerTextFieldEditing(cell: self, value: answerTextField.text!)
    }
}

extension SelectTestTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === pickerView {
            answerTextField.text = list[row]
        }
    }
}
