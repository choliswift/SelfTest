import Foundation
import RealmSwift

class TestDataModel: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var number: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
