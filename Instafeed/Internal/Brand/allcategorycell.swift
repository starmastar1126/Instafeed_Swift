//
//  allcategorycell.swift
//  Instafeed
//
//  Created by gulam ali on 02/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class allcategorycell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var boxbtn_otlt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func boxtapped(_ sender: Any) {
    }
    
}
