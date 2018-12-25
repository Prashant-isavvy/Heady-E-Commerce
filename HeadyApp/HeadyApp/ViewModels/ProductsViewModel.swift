//
//  ProductsViewModel.swift
//  HeadyApp
//
//  Created by Apple on 24/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData
class ProductsViewModel: NSObject {
    var products:[NSManagedObject]? = []
    var productsViewController:ProductsViewController?
    
    deinit {
        self.productsViewController = nil
    }
    func initViewModel(_ controller: ProductsViewController,_ category:Int){
        self.productsViewController = controller
        self.products = kCoreDateHandler.getProducts(category)
        self.productsViewController?.tblProducts.reloadData()
    }
}
