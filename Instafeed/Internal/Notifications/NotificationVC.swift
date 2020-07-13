//
//  NotificationVC.swift
//  Instafeed
//
//  Created by gulam ali on 09/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    
    
    @IBOutlet weak var tblview: UITableView!
    
    var headings:[String] = ["Alex Edward Martinez","Stark and 15 other liked your post","Amber and 20 other liked your post"]

    var subheading = ["I am intrested on taking your property on rent.","",""]
    var time = ["9.45 AM","yesterday","Now"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        tblview.rowHeight = UITableView.automaticDimension
        tblview.estimatedRowHeight = 150
        navigationBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tblview.estimatedRowHeight = 150
//        tblview.rowHeight = UITableView.automaticDimension
//    }
    
    //MARK:>>>>> Navigationbar setup
    fileprivate func navigationBarSetup(){
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        
       // self.title = "Notifications"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "orangeback"), for: .normal)
        btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(BackTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        
    }
    
    @objc func BackTapped(){
        navigationController?.popViewController(animated: false)
    }
    deinit {
        print("notificationVc removed")
    }
}



extension NotificationVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Notificationcell") as! Notificationcell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
//
}
