//
//  ProductViewModel.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class ProductViewModel: NSObject {
    
    var product:NSManagedObject?
    var variants:[NSManagedObject]?
    var productViewController:ProductDetailsViewController?
    
    deinit {
        self.productViewController = nil
    }
    func initViewModel(_ controller: ProductDetailsViewController,_ productId:Int ){
        self.productViewController = controller
        self.product = kCoreDateHandler.getProductDetail(productId)
        self.variants = kCoreDateHandler.getVariants(productId)
        self.productViewController?.updateUI()
    }
}
