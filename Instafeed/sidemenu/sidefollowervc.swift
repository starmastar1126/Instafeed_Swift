//
//  sidefollowervc.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class sidefollowervc: UIViewController {
    
    
    @IBOutlet weak var tblview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backtaped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    

}

extension sidefollowervc : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sidefollowerscell") as! sidefollowerscell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    
}
