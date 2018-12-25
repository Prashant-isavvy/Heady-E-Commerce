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

enum StoryBoard: String {
    case main = "Main"
}
enum ViewController: String {
    case categories = "CategoriesViewController"
    case subCategory = "SubCategoriesViewController"
    case products = "ProductsViewController"
    case productDetail = "ProductDetailsViewController"
    
}
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
        
        static let kProductId = "productId"
        static let kVariants = "variants"
        static let kProductColor = "color"
        static let kProductSize = "size"
        static let kProductPrice = "price"
        
        static let kTax = "tax"
        static let kTaxValue = "value"
        
        static let kHasProducts = "hasProducts"
        static let kHasCategories = "hasCategories"
        
        
        
    }
    struct CoreDataEntity {
        static let kCategories = "ProductCategory"
         static let kProduct = "Product"
        static let kVarient = "Varient"
    }
    struct tableViewCells {
        static let kCategoryCell = "CategoryTableViewCell"
        static let kProductCell = "ProductTableViewCell"
        static let kVariantCell = "ProductTableViewCell"
    }
}
