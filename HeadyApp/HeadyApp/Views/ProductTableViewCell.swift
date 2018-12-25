//
//  ProductTableViewCell.swift
//  HeadyApp
//
//  Created by Apple on 24/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setProductCell(product:NSManagedObject?) {
        self.lblProductName.text = product?.value(forKey:Constants.ParamKey.kName) as? String
        self.accessoryType = .disclosureIndicator
    }
}
