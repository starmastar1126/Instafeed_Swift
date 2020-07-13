//
//  Brandcel.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation

protocol BrandcellProtocols:class {
    func likethePost(index:IndexPath)
    func AddaComment(index:IndexPath)
    func Bookmarktap(index:IndexPath)
    func TitleTapped(index:IndexPath)
    func ShareTapped(index:IndexPath)
    func FollowTap(index:IndexPath)
}

class Brandcel: UITableViewCell {
    
    
    @IBOutlet weak var videoview: UIView!
    @IBOutlet weak var totalhearts: UILabel!
    @IBOutlet weak var heartbtn_otlt: UIButton!
    
    @IBOutlet weak var newsimage: UIImageView!
    @IBOutlet weak var newsheadline: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var commentbtn_otlt: UIButton!
    
    
    @IBOutlet weak var totalcomments: UILabel!
    
    @IBOutlet weak var sharebtn_otlt: UIButton!
    
    @IBOutlet weak var totalshares: UILabel!
    
    
    
    var avplayer = AVPlayer()
    weak var delegate:BrandcellProtocols!
    var myIndexpath:IndexPath!
    
    var BrandFeeds:brandfeedsData!{
        didSet{
            newsheadline.text = BrandFeeds.title
            name.text = BrandFeeds.username
            date.text = BrandFeeds.dt_added
            
            let isalreadyliked = BrandFeeds.is_like
            if isalreadyliked == "0"{
                //show empty heart
                let image = UIImage(named: "heart")
                heartbtn_otlt.setImage(image, for: .normal)
            }else{
               //show filled hert
                let image = UIImage(named: "filledHeart")
                heartbtn_otlt.setImage(image, for: .normal)
            }
            
            let hasVideo = BrandFeeds.video_360x290
             let postImage = BrandFeeds.image_360x290
            if hasVideo == ""{
                //hide video view
                videoview.isHidden = true
                newsimage.isHidden = false
                let postimagee = URL(string: postImage ?? "")
                let place = UIImage(named: "citizelcell")
                newsimage.sd_setImage(with: postimagee, placeholderImage: place, options: .progressiveLoad, context: nil)
            }else{
                //show video view
                videoview.isHidden = false
                newsimage.isHidden = true
                playVideo(videoURL: hasVideo!)
            }
            
            totalhearts.text = BrandFeeds.total_likes
            totalcomments.text = BrandFeeds.total_comments
            totalshares.text = BrandFeeds.total_views
            
            let userPic = BrandFeeds.avatar
            let profilephoto = URL(string: userPic ?? "")
            let placeholder = UIImage(named: "proo")
            profile.contentMode = .scaleAspectFill
            profile.sd_setImage(with: profilephoto, placeholderImage: placeholder, options: .progressiveLoad, context: nil)
   
            
        }
    }
    
    override func layoutSubviews() {
        profile.layer.cornerRadius = profile.frame.height/2
    }
    
    fileprivate func playVideo(videoURL:String){
        let videoUrl = NSURL(string: videoURL)
        avplayer = AVPlayer(url: videoUrl! as URL)
        let playerlayer = AVPlayerLayer(player: avplayer)
        playerlayer.frame = videoview.bounds
        videoview.layer.addSublayer(playerlayer)
        playerlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avplayer.play()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback)
            //try AVAudioSession.sharedInstance().setCategory(.playback)
        }catch{
            print("catched")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func heartTapped(_ sender: Any) {
        delegate.likethePost(index: myIndexpath)
    }
    
    
    
    @IBAction func commentTapped(_ sender: Any) {
        delegate.AddaComment(index: myIndexpath)
    }
    
    
    
    @IBAction func threedotsTapped(_ sender: Any) {
        delegate.Bookmarktap(index: myIndexpath)
    }
    
    
    
    @IBAction func brandTitlrTapped(_ sender: Any) {
        delegate.TitleTapped(index: myIndexpath)
    }
    
    
    @IBAction func sharetapped(_ sender: Any) {
        delegate.ShareTapped(index: myIndexpath)
    }
    
    
    @IBAction func followtapped(_ sender: Any) {
        delegate.FollowTap(index: myIndexpath)
    }
    
}
