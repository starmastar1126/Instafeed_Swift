//
//  citizencell.swift
//  Instafeed
//
//  Created by gulam ali on 12/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage


class citizencell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var circlebtn: UIButton!
    @IBOutlet weak var myview: UIView!
    
    @IBOutlet weak var recentimg: UIImageView!
    
    var recents:citizenRecentsData!{
        didSet{
           myview.layer.cornerRadius = 10.0
            title.text = recents.name
            circlebtn.layer.cornerRadius = 0.5 * circlebtn!.bounds.size.width
            
            let recentimage = URL(string: recents.image ?? "")
            recentimg.contentMode = .scaleAspectFill
            recentimg.sd_setImage(with: recentimage, placeholderImage: nil, options: .progressiveLoad, context: nil)
        }
    }
    
}
