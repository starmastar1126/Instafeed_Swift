//
//  testcase.swift
//  Instafeed
//
//  Created by gulam ali on 23/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class testcase: UIViewController {
    
    
    
    @IBOutlet weak var tblview: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.delegate = self
        tblview.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension testcase : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell") as! testcell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    
}
