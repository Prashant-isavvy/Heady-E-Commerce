//
//  CategoriesViewModel.swift
//  HeadyApp
//
//  Created by Apple on 21/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewModel: NSObject {
    var categories:[NSManagedObject]? = []
    var categoriesViewController:CategoriesViewController?
    deinit {
        self.categoriesViewController = nil
    }
    func initViewModel(_ controller: CategoriesViewController){
        self.categoriesViewController = controller
        self.categories = kCoreDateHandler.getMainCategories()
        if self.categories?.count == 0
        {
            self.getCategoriesDataFromServer { (success, response) in
                self.categoriesViewController?.tblCategories.reloadData()
            }
        }
    }
    
    func products(_ withCategorye:String) -> [NSManagedObject] {
        
        return []
    }
    func childCategories() -> [NSManagedObject] {
        return []
    }
}
extension CategoriesViewModel
{
    
    func getCategoriesDataFromServer(_ completion: @escaping CompletionHandler){
        self.categoriesViewController?.showLoadingIndicator()
        Interface().getList { (success, response) in
            self.categoriesViewController?.hideLoadingIndicator()
            if success
            {
                DispatchQueue.main.async
                    {
                        self.categories = kCoreDateHandler.getMainCategories()
                        self.categoriesViewController?.tblCategories.reloadData()
                        completion(true,self.categories)
                    }
            }
            else
            {
                if let message = response as? String{
                     UIAlertController.init(title: "", message: message, defaultActionButtonTitle: "OK", tintColor: .blue).show()
                }
            }
             self.categoriesViewController?.hideLoadingIndicator()
        }
    }
    
}
