//
//  Company+CoreDataProperties.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?
    @NSManaged public var employee: Employee?

}

extension Company : Identifiable {

}
