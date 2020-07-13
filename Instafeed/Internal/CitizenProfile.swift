//
//  CitizenProfile.swift
//  Instafeed
//
//  Created by gulam ali on 11/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class CitizenProfile: UIViewController {

    @IBOutlet weak var tblview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
        tblview.rowHeight = UITableView.automaticDimension
        tblview.estimatedRowHeight = 380
    }
    
    
    
    @IBAction func backtapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    

    deinit {
        print("citizenProfile removed")
    }

}

extension CitizenProfile : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citizenprofileCell") as! citizenprofileCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
