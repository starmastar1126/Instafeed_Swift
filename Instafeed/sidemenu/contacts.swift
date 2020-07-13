//
//  contacts.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class contacts: UIViewController {
    
    

    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var followall_btn_otlt: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        followall_btn_otlt.layer.cornerRadius = 6.0
        tblview.delegate = self
        tblview.dataSource = self
    }
    


}

extension contacts : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell") as! contactcell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
