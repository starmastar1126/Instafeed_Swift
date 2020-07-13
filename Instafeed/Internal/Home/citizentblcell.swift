//
//  citizentblcell.swift
//  Instafeed
//
//  Created by gulam ali on 12/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation


protocol CitizenFeedsProtocols: class{
    func userHasLikedThePost(index:IndexPath)
    func writeComment(index:IndexPath)
    func bookmarkTap(index:IndexPath)
    func citizenTitletapped(index:IndexPath)
    func Sharetap(index:IndexPath)
}

class citizentblcell: UITableViewCell {

    @IBOutlet weak var videoview: UIView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var seemorebtn: UIButton!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var feedimage: UIImageView!
    @IBOutlet weak var heartbtn_otlt: UIButton!
    @IBOutlet weak var totslhearts: UILabel!
    @IBOutlet weak var totalcomments: UILabel!
    @IBOutlet weak var comment_otlt: UIButton!
    @IBOutlet weak var share_otlt: UIButton!
    @IBOutlet weak var totalshares: UILabel!
    
    
    
    
    
    
//    @IBAction func Bottombartapped(_ sender: Any) {
//
//        switch ((sender as AnyObject).tag) {
//        case 10:
//            print("heart tapped")
//          //  userLikedPost()
//
//        case 20:
//            print("comment tapped")
//
//        case 30:
//            print("share tapped")
//
//        case 40:
//            print("bookmark tapped")
//
//        default:
//            break
//        }
//
//    }
    
    
    var avplayer = AVPlayer()
    var didtap_SeeMore : ((Int) -> Void)?
   // var LikethePost : ((citizenFeedsData) -> Void)?
    var myindexpath:IndexPath!
    weak var tableobj:UITableView!
    weak var delegate:CitizenFeedsProtocols!
   // weak var viewcontrol:UIViewController!
    
    var Newsfeeds:citizenFeedsData!{
        didSet{
           
            feedText.text = Newsfeeds.short_description

            seemoreSetup()
            let fulllname = Newsfeeds.username
            let totlalikes = Newsfeeds.total_likes
            let totlComments = Newsfeeds.total_comments
            let totalviews = Newsfeeds.total_views
            let userPic = Newsfeeds.avatar
            
            let postImage = Newsfeeds.image_360x290
            let posteddate = Newsfeeds.dt_added
            
            fullname.text = fulllname
            date.text = posteddate
            totslhearts.text = totlalikes
            totalcomments.text = totlComments
            totalshares.text = totalviews
            
            let userhasLiked = Newsfeeds.is_like
            if userhasLiked == "0"{
                let image = UIImage(named: "heart")
                heartbtn_otlt.setImage(image, for: .normal)
            }else{
                //show red heart filledHeart
                let image = UIImage(named: "filledHeart")
                heartbtn_otlt.setImage(image, for: .normal)
            }
            
            let profilephoto = URL(string: userPic ?? "")
            let placeholder = UIImage(named: "proo")
            profileimg.contentMode = .scaleAspectFill
            profileimg.sd_setImage(with: profilephoto, placeholderImage: placeholder, options: .progressiveLoad, context: nil)
            
           let postVideo = Newsfeeds.video_360x290
            
            if postVideo == "" {
                //hide videoview
                videoview.isHidden = true
                feedimage.isHidden = false
                let postimagee = URL(string: postImage ?? "")
                let place = UIImage(named: "citizelcell")

                feedimage.sd_setImage(with: postimagee, placeholderImage: place, options: .progressiveLoad, context: nil)
            }else{
                //show video view
                videoview.isHidden = false
                feedimage.isHidden = true
                playVideo(videoURL: postVideo!)
            }
            
        }
    }
    
    override func layoutSubviews() {
        profileimg.layer.cornerRadius = profileimg.frame.height/2
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
    
    //MARK::>>>> SEE NORE OR SEE LESS ADJUSTMENTS
    fileprivate func seemoreSetup(){
        if feedText.CountLabel(label: feedText) > 2{
            seemorebtn.isHidden = false
            
            didtap_SeeMore = { [weak self] index in
                
                if self?.seemorebtn.titleLabel?.text == "See less"{
                    self?.seemorebtn.setTitle("See more", for: .normal)
                    self?.feedText.numberOfLines = 2
                }else{
                    self?.seemorebtn.setTitle("See less", for: .normal)
                    self?.feedText.numberOfLines = 0
                }
                self?.tableobj.reloadData()
                
            }
            
        }else{
            seemorebtn.isHidden = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    
    
    @IBAction func seemore_tapped(_ sender: Any) {
         didtap_SeeMore?(myindexpath.row)
    }
    
    
    
    @IBAction func heartTapped(_ sender: Any) {
        delegate.userHasLikedThePost(index: myindexpath)
    }
    
    
    @IBAction func commentTapped(_ sender: Any) {
        delegate.writeComment(index: myindexpath)
    }
    
    
    
    @IBAction func bookmarkTapped(_ sender: Any) {
       delegate.bookmarkTap(index: myindexpath)
    }
    
    
    
    @IBAction func titleTapped(_ sender: Any) {
        delegate.citizenTitletapped(index: myindexpath)
    }
    
    
    @IBAction func sharetapped(_ sender: Any) {
        delegate.Sharetap(index: myindexpath)
    }
    
    
}




