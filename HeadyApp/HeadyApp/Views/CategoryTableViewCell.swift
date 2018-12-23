//
//  CategoryTableViewCell.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblAvailableSubCategories: UILabel!
    @IBOutlet weak var lblNumberOfProducts: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCategoriesCell(category:NSManagedObject?) {
        self.lblCategory.text = category?.value(forKey:Constants.ParamKey.kName) as? String
    }
}
