import UIKit
import RealmSwift

protocol TestTableViewCellDelegate: AnyObject {
    func editCell(_ cell: UITableViewCell)
    func deleteCell(_ cell: UITableViewCell)
}


final class TestTableViewCell: UITableViewCell {
    
    weak var delegate: TestTableViewCellDelegate?
    
    var testCountNumber = "10" //問題の数をカウントする記述は後ほど予定
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func editButton(_ sender: UIButton) {
        delegate?.editCell(self)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.deleteCell(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(_ model: TestDataModel) {
        titleLabel.text = model.title
        countLabel.text = testCountNumber
    }
}
