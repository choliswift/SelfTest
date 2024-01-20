import UIKit
import RealmSwift

protocol TestTableViewCellDelegate {
    func editCell(_ cell: UITableViewCell)
    func deleteCell(_ cell: UITableViewCell)
}


class TestTableViewCell: UITableViewCell {
    
    var delegate: TestTableViewCellDelegate?
    
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
        countLabel.text = "10"
    }
}
