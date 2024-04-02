//
//  Car+CoreDataProperties.swift
//  TMS-IOS-LESSON-31-32-HW
//
//  Created by mac on 29.03.24.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car_CoreData")
    }

    @NSManaged public var id: String?
    @NSManaged public var mark: String?
    @NSManaged public var maxSpeed: String?
    @NSManaged public var model: String?
    @NSManaged public var year: String?

}

extension Car : Identifiable {

}
