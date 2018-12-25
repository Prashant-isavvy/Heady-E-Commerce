//
//  CategoriesViewController.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseViewController {

    @IBOutlet var categoryViewModel: CategoriesViewModel!
    @IBOutlet weak var tblCategories: UITableView!
    
    
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
        self.categoryViewModel.initViewModel(self)
    }
    
    deinit {
        self.categoryViewModel = nil
    }

}
extension CategoriesViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kCategoryCell, for: indexPath) as! CategoryTableViewCell
        cell.setCategoriesCell(category: categoryViewModel.categories?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return categoryViewModel.categories?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryViewModel.categories?[indexPath.row]
        if let hasCategories = category?.value(forKey: Constants.ParamKey.kHasCategories) as? Bool , hasCategories == true
        {
           let subCategoryVC = viewController(withStoryboard: .main, controllerName: .subCategory) as! SubCategoriesViewController
             subCategoryVC.categoryId = category?.value(forKey: Constants.ParamKey.kId) as? Int
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
        }
    }
}
