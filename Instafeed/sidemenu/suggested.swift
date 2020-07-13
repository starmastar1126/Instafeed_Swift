//
//  suggested.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class suggested: UIViewController {
    
    
    @IBOutlet weak var tblview: UITableView!
    
    
    let sectionTitles = ["New suggestions","All suggestions"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.delegate = self
        tblview.dataSource = self
    }
    

}

extension suggested : UITableViewDataSource,UITableViewDelegate{
    
    
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestedcell") as! suggestedcell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
}
