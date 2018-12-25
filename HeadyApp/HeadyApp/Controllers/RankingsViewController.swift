//
//  RankingsViewController.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class RankingsViewController: BaseViewController {
    
    @IBOutlet weak var tblRankings: UITableView!
    @IBOutlet var rankingViewModel: RankingViewModel!
    @IBOutlet var sengmentControll:UISegmentedControl!
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
        self.title = "Product Rankings"
        self.rankingViewModel.initViewModel(self)
    }
    
    @IBAction func segmentTapped(_ sender: Any) {
        self.tblRankings.reloadData()
    }
    
}
extension RankingsViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCells.kRankCell, for: indexPath) as! RankingTableViewCell
      
        switch self.sengmentControll.selectedSegmentIndex {
        case 0:
          cell.setRankingCell(rank: rankingViewModel.mostViewedProducts?[indexPath.row])
        case 1:
            cell.setRankingCell(rank: rankingViewModel.mostOrderedProducts?[indexPath.row])
        case 2:
            cell.setRankingCell(rank: rankingViewModel.mostSharedProducts?[indexPath.row])
        default:
            cell.setRankingCell(rank:nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch self.sengmentControll.selectedSegmentIndex {
        case 0:
           return rankingViewModel.mostViewedProducts?.count ?? 0
        case 1:
           return rankingViewModel.mostOrderedProducts?.count ?? 0
        case 2:
           return rankingViewModel.mostSharedProducts?.count ?? 0
        default:
           return 0
        }
        return 0
    }
    
}
