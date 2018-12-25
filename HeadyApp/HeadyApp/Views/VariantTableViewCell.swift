//
//  VariantTableViewCell.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class VariantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setProductCell(category:NSManagedObject?) {
        
        self.lblSize.text = category?.value(forKey:Constants.ParamKey.kName) as? String
        
    }
}
