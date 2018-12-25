//
//  ProductDetailsViewController.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController {

    @IBOutlet var productViewModel: ProductViewModel!
    @IBOutlet weak var lblTaxType: UILabel!
    @IBOutlet weak var lblTaxValue: UILabel!
    @IBOutlet weak var tblVariants: UITableView!
    
    var productId:Int?
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
        productViewModel.initViewModel(self,productId ?? 0 )
    }
    func updateUI()
    {
        self.lblTaxType.text = self.productViewModel.product?.value(forKey: Constants.ParamKey.kTax) as? String ?? ""
        self.lblTaxValue.text =  "\(self.productViewModel.product?.value(forKey: Constants.ParamKey.kTaxValue) as? Double ?? 0.0)"
        self.tblVariants.reloadData()
    }
}
extension ProductDetailsViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kVariantCell, for: indexPath) as! VariantTableViewCell
        cell.setProductCell(category: productViewModel.variants?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productViewModel.variants?.count ?? 0
    }
}

