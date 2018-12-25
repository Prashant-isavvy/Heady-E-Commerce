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
        self.lblTaxValue.text =  "All variants of this product will be added \(self.productViewModel.product?.value(forKey: Constants.ParamKey.kTaxValue) as? Double ?? 0.0)% \(self.productViewModel.product?.value(forKey: Constants.ParamKey.kTax) as? String ?? "") extra."
        
        self.tblVariants.reloadData()
    }
}
extension ProductDetailsViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kVariantCell, for: indexPath) as! VariantTableViewCell
        cell.setVariantCell(variant:  productViewModel.variants?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productViewModel.variants?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

