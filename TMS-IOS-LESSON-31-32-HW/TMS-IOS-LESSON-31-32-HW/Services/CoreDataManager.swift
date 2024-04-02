
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var cars: [Car_CoreData] = []
    
    private init() {
        fetchAllCars()
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TMS_IOS_LESSON_31_32_HW")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllCars() {
        if let cars = try? persistentContainer.viewContext.fetch(Car_CoreData.fetchRequest()) {
            print(cars)
            self.cars = cars
        }
    }
    
    func addCar(mark: String, model: String, year: String, maxSpeed: String, completion: (() -> ())) {
        let car = Car_CoreData(context: persistentContainer.viewContext)
        car.id = UUID().uuidString
        car.mark = mark
        car.model = model
        car.year = year
        car.maxSpeed = maxSpeed
        
        saveContext()
        fetchAllCars()
        completion()
    }
    
    func removeCar(car: AnyObject, completion: (() -> ())) {
        let innerCar = car as! Car_CoreData
        innerCar.removeCar()
        cars.removeAll { c in
            c.id == car.id
        }
        completion()
    }
}
