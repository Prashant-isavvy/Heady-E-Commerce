//
//  CoreDataHandler.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import Foundation
import CoreData
enum RankingType:String {
    case mostViewed = "Most Viewed Products"
    case mostOrdered = "Most OrdeRed Products"
    case mostShared = "Most ShaRed Products"
}
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
    func saveVarients(withProduct:Int, varients:[[String:Any]]){
        for varient in varients
        {
            if let id = varient[Constants.ParamKey.kId] as? Int
            {
                let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataEntity.kVarient, in: mainContext)
                let newVarient = NSManagedObject(entity: entity!, insertInto: mainContext)
                newVarient.setValue(id, forKey: Constants.ParamKey.kId)
                newVarient.setValue(varient[Constants.ParamKey.kProductColor] as? String, forKey: Constants.ParamKey.kProductColor)
                newVarient.setValue(withProduct, forKey: Constants.ParamKey.kProductId)
               
                if (varient[Constants.ParamKey.kProductSize] as? Int) != nil{
                    newVarient.setValue(varient[Constants.ParamKey.kProductSize], forKey: Constants.ParamKey.kProductSize)
                }
                if (varient[Constants.ParamKey.kProductPrice] as? Double) != nil {
                  newVarient.setValue(varient[Constants.ParamKey.kProductPrice], forKey: Constants.ParamKey.kProductPrice)
                }
            }
        }
    }
    func saveProducts(_ withCategory:Int, _ products:[[String:Any]]) {
        for product in products
        {
            if let id = product[Constants.ParamKey.kId] as? Int
            {
                let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataEntity.kProduct, in: mainContext)
                let newProduct = NSManagedObject(entity: entity!, insertInto: mainContext)
                newProduct.setValue(id, forKey: Constants.ParamKey.kId)
                newProduct.setValue(product[Constants.ParamKey.kName] as? String, forKey: Constants.ParamKey.kName)
                newProduct.setValue(withCategory, forKey: Constants.ParamKey.kCategoryId)
                newProduct.setValue(product[Constants.ParamKey.kDateAdded], forKey: Constants.ParamKey.kDateAdded)
                if let tax = product[Constants.ParamKey.kTax] as? [String:Any]{
                    newProduct.setValue(tax[Constants.ParamKey.kName], forKey: Constants.ParamKey.kTax)
                    newProduct.setValue(tax[Constants.ParamKey.kTaxValue], forKey: Constants.ParamKey.kTaxValue)
                }
                if let varients = product[Constants.ParamKey.kVariants] as? [[String:Any]],varients.count > 0{
                    self.saveVarients(withProduct: id, varients: varients)
                }
            }
        }
    }
    
    func saveRankings( _ rankings:[[String:Any]]) {
        for ranking in rankings
        {
            if let rankingType = ranking[Constants.ParamKey.kRanking] as? String
            {
                if let products = ranking[Constants.ParamKey.kProducts] as? [[String:Any]]{
                    for product in products{
                        let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataEntity.kRanking, in: mainContext)
                        let newRank = NSManagedObject(entity: entity!, insertInto: mainContext)
                        newRank.setValue(product[Constants.ParamKey.kId], forKey: Constants.ParamKey.kProductId)
                        
                        if rankingType == RankingType.mostViewed.rawValue
                        {
                           newRank.setValue(product[Constants.ParamKey.kViewCount], forKey: Constants.ParamKey.kCounts)
                        }
                        else if rankingType == RankingType.mostOrdered.rawValue{
                             newRank.setValue(product[Constants.ParamKey.kOrderCount], forKey: Constants.ParamKey.kCounts)
                        }
                        else if rankingType == RankingType.mostShared.rawValue{
                             newRank.setValue(product[Constants.ParamKey.kShareCount], forKey: Constants.ParamKey.kCounts)
                        }
                        newRank.setValue(rankingType, forKey: Constants.ParamKey.kRankingType)
                      
                        let productDetail = kCoreDateHandler.getProductDetail(product[Constants.ParamKey.kId] as? Int ?? 0)
                        if let name = productDetail.value(forKey: Constants.ParamKey.kName) as? String{
                             newRank.setValue(name, forKey: Constants.ParamKey.kProductName)
                        }
                       
                    }
                }
            }
        }
    }
    
    func saveToCategoriesInCoreData(categories:[[String:Any]],rankings:[[String:Any]]){
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
                    if let childCat = category[Constants.ParamKey.kChildCategories] as? [Int],childCat.count > 0
                    {
                        newCategory.setValue(true, forKey: Constants.ParamKey.kHasCategories)
                    }
                    for categoryParent in categories{
                        if let childCat = categoryParent[Constants.ParamKey.kChildCategories] as? [Int],childCat.count > 0
                        {
                            for childId in childCat
                            {
                                if childId == id
                                {
                                    newCategory.setValue(categoryParent[Constants.ParamKey.kId] as? Int, forKey: Constants.ParamKey.kCategoryId)
                                }
                            }
                        }
                    }
                   // saving products according to categories
                    if let products = category[Constants.ParamKey.kProducts] as? [[String:Any]], products.count > 0{
                        newCategory.setValue(true, forKey: Constants.ParamKey.kHasProducts)
                        self.saveProducts(id, products)
                    }
                    else
                    {
                        newCategory.setValue(false, forKey: Constants.ParamKey.kHasProducts)
                    }
                    
                }
            }
            
            self.saveRankings(rankings)
            
            do {
                try mainContext.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    
    func getMainCategories() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kCategories)
        let predicate = NSPredicate(format: "hasCategories == %@", NSNumber(value: true))
        let predicate1 = NSPredicate(format: "categoryId = 0")
        let predicateFinal:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate,predicate1] )

        request.predicate = predicateFinal
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
    func getSubCategory(_ id:Int) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kCategories)
        let predicate = NSPredicate(format: "id = %d", id)
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
        }
    }
    func getCategories(_ category:Int) -> [NSManagedObject]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kCategories)
        let predicate = NSPredicate(format: "categoryId = %d", category)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject]{
                
                var allSubCategories:[NSManagedObject] = []
                for category in finalResult{
                    let id = category.value(forKey: Constants.ParamKey.kId) as! Int
                  allSubCategories = allSubCategories + self.getSubCategory(id)
                }
                return allSubCategories
            }
            else
            {
                return []
            }
        } catch {
            return []
        }
    }
    
    func getProducts(_ withCategories:Int) -> [NSManagedObject]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kProduct)
        let predicate = NSPredicate(format: "categoryId = %d", withCategories)
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
        }
    }
    func getProductDetail(_ id:Int) -> NSManagedObject
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kProduct)
        let predicate = NSPredicate(format: "id = %d", id)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject],finalResult.count>0{
                return finalResult.first!
            }
            else
            {
                return NSManagedObject()
            }
        } catch {
            return NSManagedObject()
        }
    }
    func getVariants(_ forProduct:Int) -> [NSManagedObject]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kVarient)
        let predicate = NSPredicate(format: "productId = %d", forProduct)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject],finalResult.count>0{
                return finalResult
            }
            else
            {
                return []
            }
        } catch {
            return []
        }
    }
    
    func getRankings(_ forRankingType:RankingType) -> [NSManagedObject]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataEntity.kRanking)
        let predicate = NSPredicate(format: "rankingType = %@", forRankingType.rawValue)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try mainContext.fetch(request)
            if let finalResult = result as? [NSManagedObject],finalResult.count>0{
                return finalResult
            }
            else
            {
                return []
            }
        } catch {
            return []
        }
    }
}
