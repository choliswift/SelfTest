import UIKit

protocol TestTableViewCellDelegate {
    func testTableViewCellDidTapButton(cell: UITableViewCell)
}

class TestTableViewCell: UITableViewCell {
    
    var delegate: TestTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func editButton(_ sender: UIButton) {
        delegate?.testTableViewCellDidTapButton(cell: self)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(_ model: TestDataModel) {
        titleLabel.text = model.title
        countLabel.text = model.number
    }
}
