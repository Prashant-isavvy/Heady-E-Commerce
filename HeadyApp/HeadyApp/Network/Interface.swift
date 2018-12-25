//
//  StudentInterface.swift
//  IvChat
//
//  Created by Prashant on 21/12/18.
//  Copyright © 2018 Systango. All rights reserved.
//

import UIKit

enum APIType {
    case ProductData
}
class Interface: NSObject {
    
    func getList(_ completion: @escaping CompletionHandler){
        let url = URL(string: Constants.EndPoint.kGetList)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                completion(false,"returning error")
                return
            }
            guard let content = data else {
                completion(false,"not returning data")
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                completion(false,"Not containing JSON")
                return
            }
            DispatchQueue.main.sync
                {
                    
                if let categories = json[Constants.ParamKey.kCategories] as? [[String:Any]] {
                    var ranings:[[String:Any]] = []
                    if let fRankings = json[Constants.ParamKey.kRankings] as? [[String:Any]] {
                        ranings = fRankings
                    }
                    kCoreDateHandler.saveToCategoriesInCoreData(categories: categories,rankings: ranings)
                    completion(true,categories)
                }
            }
        }
        task.resume()
    }
}

