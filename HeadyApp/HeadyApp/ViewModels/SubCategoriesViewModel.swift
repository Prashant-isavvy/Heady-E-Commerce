//
//  SubCategoriesViewModel.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class SubCategoriesViewModel: NSObject {
    var subCategories: [NSManagedObject]? = []
    var subCategoriesViewController:SubCategoriesViewController?
    deinit {
        self.subCategoriesViewController = nil
    }
    func initViewModel(_ controller: SubCategoriesViewController, category:Int){
        self.subCategoriesViewController = controller
        subCategories = kCoreDateHandler.getCategories(category)
        self.subCategoriesViewController?.tblSubCategory.reloadData()
    }
}
