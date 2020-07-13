//
//  StarVc.swift
//  Instafeed
//
//  Created by gulam ali on 10/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class StarVc: UIViewController {
    
    
  //  @IBOutlet weak var collview: UICollectionView!
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var followLine: UILabel!
    
    var sectionTitles:[String] = ["Recommended Sources","Recommended Channels","Recommended Superstars"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         tabBarController?.tabBar.isHidden = false
         self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        
      
        
    }
    
    
    deinit {
        print("starvc removed")
    }

}

extension StarVc : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl = UILabel()
        lbl.text = sectionTitles[section]
        lbl.backgroundColor = UIColor.white
        lbl.font = lbl.font.withSize(15.0)
        lbl.font = UIFont.boldSystemFont(ofSize: 15.0)
        lbl.textColor = UIColor.lightGray
        return lbl
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Starcell") as! Starcell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    
}


//extension StarVc : UICollectionViewDelegate,UICollectionViewDataSource{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCollCell", for: indexPath) as! StarCollCell
//        return cell
//    }
//    
//    
//}
