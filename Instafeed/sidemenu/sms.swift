//
//  sms.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class sms: UIViewController {

    @IBOutlet weak var frominstafeedview: UIView!
    
    @IBOutlet weak var tblview: UITableView!
    
    
    @IBOutlet weak var heading: UILabel!
    
    
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if type == "sms"{
            heading.text = "Email and SMS"
            frominstafeedview.isHidden = true
        }else{
            heading.text = "From Instafeed"
            frominstafeedview.isHidden = false
        }
        
        tblview.delegate = self
        tblview.dataSource = self
    }
    

    @IBAction func backtapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
}

extension sms : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "frominstafeedCell") as! frominstafeedCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
}
