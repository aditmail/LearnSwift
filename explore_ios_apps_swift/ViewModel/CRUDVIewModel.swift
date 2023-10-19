//
//  CRUDVIewModel.swift
//  explore_ios_apps_swift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit
import CoreData

class CRUDVIewModel: NSObject {
    
    private (set) var crudData: [CRUD] = [] {
        didSet{
            self.bindDataToVC()
        }
    }
    
    var bindDataToVC: () -> () = {}
    
    override init() {
        super.init()
    }
    
    //Get All Data
    func fetchData() -> [CRUD]{
    //func fetchData(){
        var employees = [CRUD]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CRUD_Entity")
        
        do{
            let result = try manageContext.fetch(fetchRequest) as! [NSManagedObject]
            
            employees = result.map {emp in return CRUD(
                id: emp.value(forKey: "id") as! String,
                name: emp.value(forKey: "name") as! String,
                salary: emp.value(forKey: "salary") as? String ?? "0")
            }
        }catch let err{
            print(err)
        }
        
        //crudData = employees
        
        return employees
    }
    
    //Create Data
    func create(_ id:String, _ name:String, _ salary:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(
            forEntityName: "CRUD_Entity",
            in: managedContext
        )
        
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(id, forKey: "id")
        insert.setValue(name, forKey: "name")
        insert.setValue(salary, forKey: "salary")
        
        appDelegate.saveContext()
    }
    
    //Update Data
    func update(_ id: String, _ name:String, _ salary:String, _ rowID: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CRUD_Entity")
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[rowID] as! NSManagedObject
            dataToUpdate.setValue(id, forKey: "id")
            dataToUpdate.setValue(name, forKey: "name")
            dataToUpdate.setValue(salary, forKey: "salary")

            try managedContext.save()
            
            appDelegate.saveContext()
        }catch let err{
            print(err)
        }
    }
    
    //Delete Data
    func delete(_ id: String, _ rowID: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CRUD_Entity")
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest) [rowID] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
}
