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
        self.viewColor.layer.backgroundColor = UIColor.lightGray.cgColor
        self.viewColor.layer.borderWidth = 1.0
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setVariantCell(variant:NSManagedObject?) {
        self.lblSize.text = "\(variant?.value(forKey:Constants.ParamKey.kProductSize) as? Int ?? 0)"
        self.lblColor.text = variant?.value(forKey:Constants.ParamKey.kProductColor) as? String
        self.lblPrice.text = "\(variant?.value(forKey:Constants.ParamKey.kProductPrice) as? Double ?? 0.0)"
        self.viewColor.backgroundColor = UIColor.colorWithName((lblColor.text ?? "").lowercased())
    }
}
