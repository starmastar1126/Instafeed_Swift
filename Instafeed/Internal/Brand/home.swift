//
//  home.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class home: UIViewController {
    
    
    @IBOutlet weak var clctnview: UICollectionView!
    
    
    @IBOutlet weak var tblview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        clctn_tbl_setup()
    }
    
    fileprivate func clctn_tbl_setup(){
        clctnview.delegate = self
        clctnview.dataSource = self
        tblview.delegate = self
        tblview.dataSource = self
    }
    

    deinit {
        print("home removed")
    }
    

}


extension home: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColectionCell", for: indexPath) as! HomeColectionCell
        cell.newsimg.layer.cornerRadius = 8.0
        cell.newbtn.layer.cornerRadius = 5.0
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: clctnview!.bounds.width, height: clctnview!.bounds.height) // You can change width and height here as pr your requirement
        
    }
    
    
}


//MARK:>>>>>> TABLEVIEW PROTOCOLS

extension home : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hometblcell") as! hometblcell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
