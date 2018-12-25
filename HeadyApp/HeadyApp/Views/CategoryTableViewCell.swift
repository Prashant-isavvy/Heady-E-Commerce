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

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCategoriesCell(category:NSManagedObject?)
    {
        self.lblCategory.text = category?.value(forKey:Constants.ParamKey.kName) as? String
        
        if let hasCategories = category?.value(forKey: Constants.ParamKey.kHasCategories) as? Bool , hasCategories == true
        {
          self.accessoryType = .disclosureIndicator
        }
        if let hasCategories = category?.value(forKey: Constants.ParamKey.kHasProducts) as? Bool , hasCategories == true {
            self.accessoryType = .disclosureIndicator
        }
        self.imgIcon.image = UIImage(named: "\(category?.value(forKey:Constants.ParamKey.kId) ?? 0)")
    }
}
