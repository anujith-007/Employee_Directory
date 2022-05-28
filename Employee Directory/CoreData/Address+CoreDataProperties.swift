//
//  Address+CoreDataProperties.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var username: String?
    @NSManaged public var employee: Employee?

}

extension Address : Identifiable {

}
