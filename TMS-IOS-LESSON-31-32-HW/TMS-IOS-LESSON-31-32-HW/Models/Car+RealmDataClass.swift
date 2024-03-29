import RealmSwift

class Car_Realm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var mark: String
    @Persisted var model: String
    @Persisted var year: String
    @Persisted var maxSpeed: String
    
    convenience init(mark: String, model: String, year: String, maxSpeed: String) {
        self.init()
        self.mark = mark
        self.model = model
        self.year = year
        self.maxSpeed = maxSpeed
    }
}
