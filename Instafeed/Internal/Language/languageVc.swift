//
//  languageVc.swift
//  Instafeed
//
//  Created by gulam ali on 11/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class languageVc: UIViewController {
    
    @IBOutlet weak var tblview: UITableView!
    
    var languages = ["English(US)","English(UK)","Arabic","Persian","Hindi","Latin","French","German","Chinese","Koul","Japenese","Urdu","Farsi"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        let move = storyboard?.instantiateViewController(withIdentifier: "CitizenProfile") as! CitizenProfile
        navigationController?.pushViewController(move, animated: false)
    }
    

    deinit {
        print("languageVC removed")
    }

}

extension languageVc : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageCell
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
    
}
