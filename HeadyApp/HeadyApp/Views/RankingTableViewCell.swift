//
//  RankingTableViewCell.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData
class RankingTableViewCell: UITableViewCell {
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setRankingCell(rank:NSManagedObject?) {
        self.lblCount.text = "\(rank?.value(forKey:Constants.ParamKey.kCounts) as? Int ?? 0)"
        self.lblProductName.text = rank?.value(forKey:Constants.ParamKey.kProductName) as? String
    }
}
