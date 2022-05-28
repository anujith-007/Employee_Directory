//
//  Employee+CoreDataProperties.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var profile_image: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var id: Int32
    @NSManaged public var address: Address?
    @NSManaged public var company: Company?

}

extension Employee : Identifiable {

}
