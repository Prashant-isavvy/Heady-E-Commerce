//
//  CoreDataHandler.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import Foundation
import CoreData
struct CoreDataHandler {
    static let shared:CoreDataHandler = CoreDataHandler()
    func resetAllCategoriesRecords(in entity : String) // entity = Your_Entity_Name
    {
        let context = kAppDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    func saveToCategoriesInCoreData(categories:[[String:Any]]){
        DispatchQueue.main.async {
            kCoreDateHandler.resetAllCategoriesRecords(in: Constants.CoreDataEntity.kCategories)
            for category in categories
            {
                if let id = category[Constants.ParamKey.kId] as? Int
                {
                    let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataEntity.kCategories, in: mainContext)
                    let newCategory = NSManagedObject(entity: entity!, insertInto: mainContext)
                    newCategory.setValue(id, forKey: Constants.ParamKey.kId)
                    newCategory.setValue(category[Constants.ParamKey.kName] as? String, forKey: Constants.ParamKey.kName)
                    if let childCat = category[Constants.ParamKey.kChildCategories] as? [Int]
                    {
                        if childCat.count > 0
                        {
                            newCategory.setValue(-1, forKey: Constants.ParamKey.kCategoryId)
                            for childId in childCat
                            {
                                let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataEntity.kCategories, in: mainContext)
                                let newSubCategory = NSManagedObject(entity: entity!, insertInto: mainContext)
                                newSubCategory.setValue(childId, forKey: Constants.ParamKey.kId)
                                newSubCategory.setValue(id, forKey: Constants.ParamKey.kCategoryId)
                            }
                        }
                        
                    }
                }
            }
            do {
                try mainContext.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    func getMainCategories() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kCategories)
        let predicate = NSPredicate(format: "categoryId = %d", -1)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject]{
                return finalResult
            }
            else
            {
                return []
            }
        } catch {
            return []
            //print("Failed")
        }
    }
    func getFromDataBase(_ entity:String) -> [NSManagedObject]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject]{
                return finalResult
            }
            else
            {
               return []
            }
        } catch {
            return []
            //print("Failed")
        }
    }
}
