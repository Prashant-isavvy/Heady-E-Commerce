//
//  Constants.swift
//  HeadyApp
//
//  Created by Apple on 21/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import Foundation
import UIKit

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let mainContext = kAppDelegate.persistentContainer.viewContext
let kCoreDateHandler = CoreDataHandler.shared
typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

struct Constants
{
    // MARK: Enums
    enum RequestType: NSInteger {
        case GET
        case POST
        case MultiPartPost
        case DELETE
        case PUT
    }
    struct EndPoint {
        static let kGetList = "https://stark-spire-93433.herokuapp.com/json" // I need to define only methods name in server end but in this example no scope for that
    }
    struct ParamKey {
        static let kCategories = "categories"
        static let kRankings = "rankings"
        static let kChildCategories = "child_categories"
        static let kCategoryId = "categoryId"
        static let kId = "id"
        static let kProducts = "products"
        static let kName = "name"
        static let kDateAdded = "date_added"
        static let kTax = "tax"
        static let kProductColor = "color"
        static let kProductSize = "size"
        static let kProductPrice = "price"
        static let kTaxValue = "value"
        
    }
    struct CoreDataEntity {
        static let kCategories = "ProductCategory"
    }
    struct tableViewCells {
        static let kCategoryCell = "CategoryTableViewCell"
    }
}
