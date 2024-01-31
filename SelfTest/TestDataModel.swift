import Foundation
import RealmSwift
//本来はstructで作成したほうがいい
class TestDataModel: Object {
    //上書き保存をしやすいように、uuidを使用
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var kind: Int = 0
    @objc dynamic var title: String = ""
    
    //ここから文章入力問題用
    @objc dynamic var testContent1: String = ""
    @objc dynamic var testContent2: String = ""
    @objc dynamic var testContent3: String = ""
    @objc dynamic var testContent4: String = ""
    @objc dynamic var testContent5: String = ""
    @objc dynamic var testContent6: String = ""
    @objc dynamic var testContent7: String = ""
    @objc dynamic var testContent8: String = ""
    @objc dynamic var testContent9: String = ""
    @objc dynamic var testContent10: String = ""
    @objc dynamic var testAnswer1: String = ""
    @objc dynamic var testAnswer2: String = ""
    @objc dynamic var testAnswer3: String = ""
    @objc dynamic var testAnswer4: String = ""
    @objc dynamic var testAnswer5: String = ""
    @objc dynamic var testAnswer6: String = ""
    @objc dynamic var testAnswer7: String = ""
    @objc dynamic var testAnswer8: String = ""
    @objc dynamic var testAnswer9: String = ""
    @objc dynamic var testAnswer10: String = ""
    @objc dynamic var testKind: String = ""
    
    //ここから選択式問題用
    @objc dynamic var choices1of1: String = ""
    @objc dynamic var choices2of1: String = ""
    @objc dynamic var choices3of1: String = ""
    @objc dynamic var choices4of1: String = ""
    @objc dynamic var choices1of2: String = ""
    @objc dynamic var choices2of2: String = ""
    @objc dynamic var choices3of2: String = ""
    @objc dynamic var choices4of2: String = ""
    @objc dynamic var choices1of3: String = ""
    @objc dynamic var choices2of3: String = ""
    @objc dynamic var choices3of3: String = ""
    @objc dynamic var choices4of3: String = ""
    @objc dynamic var choices1of4: String = ""
    @objc dynamic var choices2of4: String = ""
    @objc dynamic var choices3of4: String = ""
    @objc dynamic var choices4of4: String = ""
    @objc dynamic var choices1of5: String = ""
    @objc dynamic var choices2of5: String = ""
    @objc dynamic var choices3of5: String = ""
    @objc dynamic var choices4of5: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
