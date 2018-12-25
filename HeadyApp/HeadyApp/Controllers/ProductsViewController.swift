//
//  ProductsViewController.swift
//  HeadyApp
//
//  Created by Apple on 24/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class ProductsViewController: BaseViewController {

    @IBOutlet var productViewModel: ProductsViewModel!
    @IBOutlet weak var tblProducts: UITableView!
    var category:Int?
    
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
        productViewModel.initViewModel(self, category ?? 0)
    }
}
extension ProductsViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kProductCell, for: indexPath) as! ProductTableViewCell
        cell.setProductCell(category: productViewModel.products?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productViewModel.products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productViewModel.products?[indexPath.row]
        
        let productVC = viewController(withStoryboard: .main, controllerName: .productDetail) as! ProductDetailsViewController
        productVC.title = product?.value(forKey: Constants.ParamKey.kName) as? String
        productVC.productId = product?.value(forKey: Constants.ParamKey.kId) as? Int
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}
