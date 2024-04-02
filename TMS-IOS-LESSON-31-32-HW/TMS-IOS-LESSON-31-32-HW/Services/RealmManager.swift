import RealmSwift
import Foundation

class RealmManager {
    static let shared = RealmManager()
    
    var realm: Realm?
    
    var cars: [Car_Realm] = []
    
    private init() {
        realm = try! Realm()
        fetchAllCars()
    }
    
    func fetchAllCars() {
        guard let realm else {return}
        let result = realm.objects(Car_Realm.self)
        cars = result.toArray(type: Car_Realm.self)
    }
    
    func addCar(mark: String, model: String, year: String, maxSpeed: String, completion: (() -> ())) {
        guard let realm else {return}
        let car = Car_Realm(mark: mark, model: model, year: year, maxSpeed: maxSpeed)
        car.id = UUID().uuidString
        try! realm.write {
            realm.add(car)
        }
       fetchAllCars()
    }
    
    func removeCar(car: AnyObject, completion: (() -> ())) {
        guard let realm else {return}
        try! realm.write {
            realm.delete(car as! Car_Realm)
        }
        fetchAllCars()
        completion()
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as?  T }
    }
}
