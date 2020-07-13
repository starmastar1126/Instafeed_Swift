//
//  allcategories.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class allcategories: UIViewController {
    
    @IBOutlet weak var tblview: UITableView!
    
     var BrandCategories = [brandTitletapdata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCategories()
        tblview.delegate = self
        tblview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblview.reloadData()
    }

    
    //MARK:>>>> Api call
    fileprivate func GetCategories(){
        let apiurl = ServerURL.firstpoint + ServerURL.brandTitletap
        networking.MakeRequest(Url: apiurl, Param: nil, vc: self) { (result:brandTitletap) in
            print(result)
            if result.message == "success"{
                if let response = result.data{
                    self.BrandCategories = response.map{$0}
                    DispatchQueue.main.async {
                self.tblview.reloadData()
                    }
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }

}
extension allcategories : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BrandCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allcategorycell") as! allcategorycell
        cell.title.text = BrandCategories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    
    
}
