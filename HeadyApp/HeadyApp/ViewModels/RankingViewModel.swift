//
//  RaningViewModel.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit
import CoreData

class RankingViewModel: NSObject {
    var mostViewedProducts:[NSManagedObject]?
    var mostOrderedProducts:[NSManagedObject]?
    var mostSharedProducts:[NSManagedObject]?
    var rankingsViewController:RankingsViewController?
    
    deinit {
        self.rankingsViewController = nil
    }
    func initViewModel(_ controller: RankingsViewController){
        self.rankingsViewController = controller
        mostViewedProducts = kCoreDateHandler.getRankings(.mostViewed)
         mostOrderedProducts = kCoreDateHandler.getRankings(.mostOrdered)
         mostSharedProducts = kCoreDateHandler.getRankings(.mostShared)
        self.rankingsViewController?.tblRankings.reloadData()
    }
}
