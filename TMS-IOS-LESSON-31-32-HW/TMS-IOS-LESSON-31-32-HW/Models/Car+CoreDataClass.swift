import Foundation
import CoreData

public class Car_CoreData: NSManagedObject {

}

extension Car_CoreData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car_CoreData> {
        return NSFetchRequest<Car_CoreData>(entityName: "Car_CoreData")
    }
    
    @NSManaged public var id: String
    @NSManaged public var mark: String
    @NSManaged public var maxSpeed: String
    @NSManaged public var model: String
    @NSManaged public var year: String

}

extension Car_CoreData : Identifiable {
    func removeCar() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
