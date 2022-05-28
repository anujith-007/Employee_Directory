//
//  CoredataHandler.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler {
    
    private let viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func insert<T: NSManagedObject>(object: T) {
        let context = viewContext
        
        context.insert(object)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func saveEmployeeData(data: EmployeeModel) {
        let context: NSManagedObjectContext = viewContext

        let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Employee", in: context)!

        let employeeInfoEntry: NSManagedObject = NSManagedObject(entity: entityDescription, insertInto: context)

        //Set your values here
        employeeInfoEntry.setValue(data.email, forKey: "email")
        employeeInfoEntry.setValue(data.name, forKey: "name")
        employeeInfoEntry.setValue(data.phone, forKey: "phone")
        employeeInfoEntry.setValue(data.profileImage, forKey: "profile_image")
        employeeInfoEntry.setValue(data.username, forKey: "username")
        employeeInfoEntry.setValue(data.website, forKey: "website")
        
       // let address = Address(context: viewContext)
        
        employeeInfoEntry.setValue(data.address, forKey: "address_details")
        employeeInfoEntry.setValue(data.company, forKey: "company_details")

        //Then save
        save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
            //Error handling
        }
    }
    
    public func getEmployeeData() -> [EmployeeModel]? {
        let employeeDataFetchRequest: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        do {
            var employeeArray = [EmployeeModel]()
            let fetchedData: [Any] = try viewContext.fetch(employeeDataFetchRequest)
            let employeeDataObjectArray: [NSManagedObject] = fetchedData as! [NSManagedObject]
            for employee in employeeDataObjectArray {
                var employeeData: EmployeeModel = EmployeeModel()
                employeeData.name = employee.value(forKey: "name") as? String
                employeeData.email = employee.value(forKey: "email") as? String
                employeeData.phone = employee.value(forKey: "phone") as? String
                employeeData.profileImage = employee.value(forKey: "profile_image") as? String
                employeeData.username = employee.value(forKey: "username") as? String
                employeeData.website = employee.value(forKey: "website") as? String
                employeeData.address = employee.value(forKey: "address_details") as? AddressData
                employeeData.company = employee.value(forKey: "company_details") as? CompanyData
                employeeArray.append(employeeData)
            }
            
            
            return employeeArray
        } catch {
            //Handle errors
            return nil
        }
    }
    
    
}
