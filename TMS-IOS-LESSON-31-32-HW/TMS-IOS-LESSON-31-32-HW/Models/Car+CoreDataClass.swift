import Foundation
import CoreData


public class Car: NSManagedObject {

}

extension Car {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }
    
    @NSManaged public var id: String
    @NSManaged public var mark: String
    @NSManaged public var maxSpeed: String
    @NSManaged public var model: String
    @NSManaged public var year: String

}

extension Car : Identifiable {
    func removeCar() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
