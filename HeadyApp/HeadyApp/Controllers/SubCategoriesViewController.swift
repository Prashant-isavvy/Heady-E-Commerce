//
//  SubCategoriesViewController.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class SubCategoriesViewController: BaseViewController {
    
    @IBOutlet weak var tblSubCategory: UITableView!
       @IBOutlet var suCategoryViewModel:SubCategoriesViewModel!
    var categoryId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreenLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpScreenLayout() {
        suCategoryViewModel.initViewModel(self, category: categoryId ?? 0)
    }
}
extension SubCategoriesViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kCategoryCell, for: indexPath) as! CategoryTableViewCell
        cell.setCategoriesCell(category: suCategoryViewModel.subCategories?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return suCategoryViewModel.subCategories?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = suCategoryViewModel.subCategories?[indexPath.row]
        if let hasCategories = category?.value(forKey: Constants.ParamKey.kHasCategories) as? Bool , hasCategories == true
        {
            let subCategoryVC = viewController(withStoryboard: .main, controllerName: .subCategory) as! SubCategoriesViewController
            subCategoryVC.title = category?.value(forKey: Constants.ParamKey.kName) as? String
            subCategoryVC.categoryId = category?.value(forKey: Constants.ParamKey.kId) as? Int
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
        }
        else if let hasProduct = category?.value(forKey: Constants.ParamKey.kHasProducts) as? Bool , hasProduct == true
        {
            let productVC = viewController(withStoryboard: .main, controllerName: .products) as! ProductsViewController
            productVC.title = category?.value(forKey: Constants.ParamKey.kName) as? String
            productVC.category = category?.value(forKey: Constants.ParamKey.kId) as? Int
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
}
