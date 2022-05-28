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
        employeeInfoEntry.setValue(data.id, forKey: "id")
        
        let entityDescription1: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Address", in: context)!

        let employeeInfoEntry1: NSManagedObject = NSManagedObject(entity: entityDescription1, insertInto: context)
        employeeInfoEntry1.setValue(data.address?.street, forKey: "street")
        employeeInfoEntry1.setValue(data.address?.suite, forKey: "suite")
        employeeInfoEntry1.setValue(data.address?.city, forKey: "city")
        employeeInfoEntry1.setValue(data.address?.zipcode, forKey: "zipcode")
        employeeInfoEntry1.setValue(data.username, forKey: "username")
        
        
        let entityDescription2: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Company", in: context)!

        let employeeInfoEntry2: NSManagedObject = NSManagedObject(entity: entityDescription2, insertInto: context)
        employeeInfoEntry2.setValue(data.company?.name, forKey: "name")
        employeeInfoEntry2.setValue(data.company?.catchPhrase, forKey: "catchPhrase")
        employeeInfoEntry2.setValue(data.company?.bs, forKey: "bs")
        employeeInfoEntry2.setValue(data.username, forKey: "username")
       // let address = Address(context: viewContext)
        

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
                employeeData.id = employee.value(forKey: "id") as? Int
                
                do {
                    let fetchRequest1: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Address")
                    let id = employee.value(forKey: "id")
                        
                    fetchRequest1.predicate = NSPredicate(format: "username == %@", employeeData.username!)
                    
                    let fetchedResults = try viewContext.fetch(fetchRequest1)
                    if let address = fetchedResults.first {
                        employeeData.address?.zipcode = address.value(forKey: "zipcode") as? String
                        employeeData.address?.city = address.value(forKey: "city") as? String
                        employeeData.address?.street = address.value(forKey: "street") as? String
                        employeeData.address?.suite = address.value(forKey: "suite") as? String
                        
                    }
                }
                catch {
                    print ("fetch task failed", error)
                }
                
                do {
                    let fetchRequest2 : NSFetchRequest<Company> = Company.fetchRequest()
                    fetchRequest2.predicate = NSPredicate(format: "username == %@", employeeData.username!)
                    let fetchedResults = try viewContext.fetch(fetchRequest2)
                    if let company = fetchedResults.first {
                        employeeData.company?.name = company.name
                        employeeData.company?.catchPhrase = company.catchPhrase
                        employeeData.company?.bs = company.bs
                        
                    }
                }
                catch {
                    print ("fetch task failed", error)
                }
                
                
                employeeArray.append(employeeData)
            }
            
            
            return employeeArray
        } catch {
            //Handle errors
            return nil
        }
    }
    
    
}
