
//
//  commentCell.swift
//  Instafeed
//
//  Created by gulam ali on 31/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

class commentCell: UITableViewCell {
    
    
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var commentlbl: UILabel!
    
    
    var citizenlist:citizenCommentListdata!{
        didSet{
            guard let firstname = citizenlist.first_name else{return}
            guard let comm = citizenlist.comment else{return}
            guard let image = citizenlist.avatar else {return}
            
            
            let fullstr = "\(firstname) \(comm)"
            commentlbl.attributedText = attributedText(withString: fullstr, boldString: firstname, font: UIFont(name: "Helvetica Neue", size: 17.0)!)
        }
    }
    
    
    
    var brandlist:brandCommentListdata!{
        didSet{
            guard let comm = brandlist.comment else {return}
            guard let firstname = brandlist.first_name else {return}
            
            let fullstr = "\(firstname) \(comm)"
            commentlbl.attributedText = attributedText(withString: fullstr, boldString: firstname, font: UIFont(name: "Helvetica Neue", size: 17.0)!)
        }
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 15.0)!])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
