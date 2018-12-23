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
        self.categoryViewModel.initChatViewModel(self)
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
}
