//
//  bookmarkcell.swift
//  Instafeed
//
//  Created by gulam ali on 05/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

protocol bookmarkcellProtocol:class {
    func Unbookmark(index:IndexPath)
}

class bookmarkcell: UITableViewCell {
    
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var postimage: UIImageView!
    
    
    weak var delegate:bookmarkcellProtocol!
    var myindexpath:IndexPath!
    
    var bookmarks:getBookmarkdata!{
        didSet{
            headline.text = bookmarks.title
            details.text = bookmarks.short_description
            
            guard let fetchedimage = bookmarks.image else {
                return
            }
            let postphoto = URL(string: fetchedimage)
            let placeholder = UIImage(named: "citizelcell")
            postimage.contentMode = .scaleAspectFill
            postimage.sd_setImage(with: postphoto, placeholderImage: placeholder, options: .progressiveLoad, context: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func unbookmarkTapped(_ sender: Any) {
        delegate.Unbookmark(index: myindexpath)
    }
    
}
