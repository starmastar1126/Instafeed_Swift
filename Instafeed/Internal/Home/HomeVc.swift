//
//  HomeVc.swift
//  Instafeed
//
//  Created by gulam ali on 12/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVc: UIViewController {
    
    
    @IBOutlet weak var brand_tblview: UITableView!
    @IBOutlet weak var citizenstoriesview: UIView!
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var collview: UICollectionView!
    @IBOutlet weak var citizenlabel: UILabel!
    @IBOutlet weak var superstarline: UILabel!
    @IBOutlet weak var superstarlabel: UILabel!
    @IBOutlet weak var brandline: UILabel!
    @IBOutlet weak var citizenline: UILabel!
    @IBOutlet weak var brandlabel: UILabel!
    
    
    var CitizenRecents = [citizenRecentsData]()
    var Citizenfeeds = [citizenFeedsData]()
    var BrandFeeds = [brandfeedsData]()
    var limit:Int = 1
    var brandlimit:Int = 1
    var FetchMore = false
   // var tabtype = String()
    
    var ViewFlag:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Table_collection_ViewSetup()
        ViewFlag = "citizen"
        brandView.isHidden = true
        getCitizenRecents()
        citizentab_getfeeds(count: limit)
        getBrandFeeds(count: brandlimit)
       
    }
    
    
    fileprivate func Table_collection_ViewSetup(){
        collview.delegate = self
        collview.dataSource = self
        
        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
        tblview.rowHeight = UITableView.automaticDimension
        tblview.estimatedRowHeight = 390
        
        brand_tblview.delegate = self
        brand_tblview.dataSource = self
        brand_tblview.tableFooterView = UIView()
        brand_tblview.rowHeight = UITableView.automaticDimension
        brand_tblview.estimatedRowHeight = 390
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func topbar_btns_action(_ sender: Any) {
       
        switch ((sender as AnyObject).tag) {
        case 10: //sidemenu btn
            print("sidemenu tap")
            //segue
            
        case 20: //notification
            print("notification")
            showNotificaton()
        case 30: //search
            print("search tap")
            let move = storyboard?.instantiateViewController(withIdentifier: "Bookmarkvc") as! Bookmarkvc
            navigationController?.pushViewController(move, animated: true)
        default:
            break
        }
        
    }
    
    fileprivate func showNotificaton(){
        let move = storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(move, animated: false)
    }
    
    
    //MARK:>>>> ViewTab action
    @IBAction func viewTabs_Tapped(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 100:
            print("citizen tab")
            showCitizenTab()
        case 110:
            print("superstar tab")
            
        case 120:
            print("brand tab")
            showBrandTab()
        default:
            break
        }
    }
    
    
    func showCitizenTab(){
        citizenlabel.textColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        citizenline.backgroundColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        superstarlabel.textColor = UIColor.lightGray
        superstarline.backgroundColor = UIColor.white
        brandlabel.textColor = UIColor.lightGray
        brandline.backgroundColor = UIColor.white
        ViewFlag = "citizen"
        brandView.isHidden = true
        citizenstoriesview.isHidden = false
        brand_tblview.isHidden = true
        tblview.isHidden = false
    }
    
   
    func showBrandTab(){
        citizenlabel.textColor = UIColor.gray
        citizenline.backgroundColor = UIColor.white
        superstarlabel.textColor = UIColor.lightGray
        superstarline.backgroundColor = UIColor.white
        brandlabel.textColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        brandline.backgroundColor = UIColor(hexValue: InstafeedColors.ThemeOrange)
        ViewFlag = "brand"
        brandView.isHidden = false
        citizenstoriesview.isHidden = true
        brand_tblview.isHidden = false
        tblview.isHidden = true
    }
    
    
                        //MARK;>>>>>>>>> API Calls
    
    //MARK:>>>>> CITIZEN TAB RECENTS
    fileprivate func getCitizenRecents(){
        let serverurl = ServerURL.firstpoint + ServerURL.citizenRecents
    
        networking.MakeRequest(Url: serverurl, Param: nil, vc: self) { (response:citizenRecents) in
            print(response)
            if response.message == "success"{
                
                if let recentsArray = response.data{
                    self.CitizenRecents = recentsArray.map{$0}
                    print("your array -> \(self.CitizenRecents)")
                    DispatchQueue.main.async {
                        self.collview.reloadData()
                    }
                }
                
            }else{
                print("not success")
            }
        }
    }
    
    //MARK:>>>>>> Citizen tab-feeds
    
    fileprivate func citizentab_getfeeds(count:Int){
        
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
           print("\(UserToken)")
        
        let apiURL = "http://13.234.116.90/api/citizen/news?lang_id=1&start=\(count)&token=\(UserToken)"
        print(apiURL)
        networking.MakeRequest(Url: apiURL, Param: nil, vc: self) { (result:citizenFeeds) in
            print(result)
            if result.message == "success"{
                if let feedsArray = result.data{
                    for data in feedsArray{
                        self.Citizenfeeds.append(data)
                    }
                    print("your array -> \(self.Citizenfeeds)")
                    DispatchQueue.main.async {
                        self.tblview.reloadData()
                    }
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
        
        
    }
    
    //MARK:>>>>> Brand tab feeds
    fileprivate func getBrandFeeds(count:Int){
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let apiURL = "http://13.234.116.90/api/brands/news?lang_id=1&start=\(count)&token=\(UserToken)"
        print(apiURL)
        networking.MakeRequest(Url: apiURL, Param: nil, vc: self) { (response:brandfeeds) in
            print(response.message)
            if response.message == "success"{
                if let feedsArray = response.data{
                    for data in feedsArray{
                        self.BrandFeeds.append(data)
                    }
                    print("your array -> \(self.BrandFeeds)")
                    DispatchQueue.main.async {
                        self.brand_tblview.reloadData()
                    }
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }

    
    @IBAction func seeallTapped(_ sender: Any) {
        tabBarController?.selectedIndex = 4
    }
    
    


    deinit {
        print("homevc removed")
    }
    

}


extension HomeVc : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return CitizenRecents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "citizencell", for: indexPath) as! citizencell
        
        let index = CitizenRecents[indexPath.row]
        cell.recents = index
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 20.0
        let numberOfItemsPerRow: CGFloat = 3.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
        
    }
    
}


extension HomeVc : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tblview{
           return Citizenfeeds.count
        }
        else if tableView == self.brand_tblview{
            return BrandFeeds.count
        }else{
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.tblview{
            let cell = tableView.dequeueReusableCell(withIdentifier: "citizentblcell") as! citizentblcell
            
            cell.myindexpath = indexPath
            cell.delegate = self
            cell.tableobj = tblview
            let feedOnIndex = Citizenfeeds[indexPath.row]
            cell.Newsfeeds = feedOnIndex
            return cell
            
        }else if tableView == self.brand_tblview{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Brandcel") as! Brandcel
            cell.BrandFeeds = BrandFeeds[indexPath.row]
            cell.myIndexpath = indexPath
            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "citizentblcell") as! citizentblcell
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == self.tblview{
            guard let videoCell = (cell as? citizentblcell) else { return }
            if (tableView.visibleCells.first != nil){
                //videoCell.soundbtn.isSelected = true
                videoCell.avplayer.play()
            }else{
                videoCell.avplayer.pause()
            }
        }else if tableView == self.brand_tblview{
            guard let videoCell = (cell as? Brandcel) else { return }
            if (tableView.visibleCells.first != nil){
                //videoCell.soundbtn.isSelected = true
                videoCell.avplayer.play()
            }else{
                videoCell.avplayer.pause()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == self.tblview{
            guard let videoCell = cell as? citizentblcell else { return };
           // videoCell.soundbtn.isSelected = false
            videoCell.avplayer.pause()
            videoCell.avplayer.replaceCurrentItem(with: nil)

        }else if tableView == self.brand_tblview{
            guard let videoCell = cell as? Brandcel else { return };
            // videoCell.soundbtn.isSelected = false
            videoCell.avplayer.pause()
            videoCell.avplayer.replaceCurrentItem(with: nil)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
        if ViewFlag == "citizen"{
            infiniteScroll(scrollView: scrollView)
        }else if ViewFlag == "brand"{
            infiniteScroll(scrollView: scrollView)
        }
        
        
        
    }
    
    private func infiniteScroll(scrollView:UIScrollView){
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >  contentHeight - scrollView.frame.height{
            if !FetchMore {
                //print("begin batch fetch")
                BeginBatchFetch()
            }else{
                //print("not call")
            }
        }
    }

    //MARK:>>> TO fetch more data from server
    func BeginBatchFetch(){
        FetchMore = true
        print("begin batch fetch")
        //hit api again to get more feeds for citizen and brand
        if ViewFlag == "citizen"{
            limit = limit + 10
            citizentab_getfeeds(count: limit)
        }else if ViewFlag == "brand" {
            brandlimit  = brandlimit + 10
            getBrandFeeds(count: brandlimit)
        }
    }
    
}

extension HomeVc : CitizenFeedsProtocols{
   

    func userHasLikedThePost(index: IndexPath) {
        guard let postID = Citizenfeeds[index.row].id else {return}
        guard let islikedAlready = Citizenfeeds[index.row].is_like else {return}
        
        if islikedAlready == "0"{
            //turn red heart
            likePostAPi(postId: postID, index: index)
        }else{
            //disliked
            DislikePostAPi(postId: postID, index: index)
        }
    }
    
    
    func writeComment(index: IndexPath) {
         //guard let postID = Citizenfeeds[index.row].short_description else {return}
        let move = storyboard?.instantiateViewController(withIdentifier: "CommentVc") as! CommentVc
         move.TabType = "citizen"
        move.citizendata = Citizenfeeds[index.row]
        navigationController?.pushViewController(move, animated: true)
    }
    
    
    func bookmarkTap(index: IndexPath) {
        print("bookmark tap citizen")
        guard let postID = Citizenfeeds[index.row].id else {return}
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        CommonFuncs.addbookmark(vc: self, postid: postID, token: UserToken)
    }
    
    func citizenTitletapped(index: IndexPath) {
        let move = storyboard?.instantiateViewController(withIdentifier: "CitizenProfile") as! CitizenProfile
        navigationController?.pushViewController(move, animated: false)
    }
    
    
    func Sharetap(index: IndexPath) {
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let imageToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    //MARK:>>>>> Like post api call
    func likePostAPi(postId:String,index:IndexPath){
        let apiurl = ServerURL.firstpoint + ServerURL.likepost
       // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let params = ["token":UserToken, "id":postId, "vote":"u", "type":"1"] as [String:Any]
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:likePost) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    DispatchQueue.main.async {
                        self.citizentab_getfeeds(count: self.limit)
                    }
                }
            }
        }
    }

    
    //MARK:>>>>> Dislike the post
    
    func DislikePostAPi(postId:String,index:IndexPath){
        let apiurl = ServerURL.firstpoint + ServerURL.likepost
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let params = ["token":UserToken, "id":postId, "vote":"d", "type":"1"] as [String:Any]
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:dislikePost) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    DispatchQueue.main.async {
                        self.citizentab_getfeeds(count: self.limit)
                    }
                }
            }
        }
    }
    
    
}

extension HomeVc : BrandcellProtocols{
    

    func likethePost(index: IndexPath) {
        guard let postID = BrandFeeds[index.row].id else {return}
        guard let islikedAlready = BrandFeeds[index.row].is_like else {return}
        
        if islikedAlready == "0"{
            //like post
            BrandPostLikeAPi(postId: postID, index: index)
        }else{
            //dislike post
            BrandPostDisLikeAPi(postId: postID, index: index)
        }
    }
    
    func AddaComment(index: IndexPath) {
        let move = storyboard?.instantiateViewController(withIdentifier: "CommentVc") as! CommentVc
        move.TabType = "brand"
        move.brandFeeddata = BrandFeeds[index.row]
        navigationController?.pushViewController(move, animated: true)
    }
    
    
    func Bookmarktap(index: IndexPath) {
        CommonFuncs.CallActionsheet(vc: self) {
            print("brand bookmark tapped")
            guard let postID = self.BrandFeeds[index.row].id else {return}
            guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
            CommonFuncs.addbookmark(vc: self, postid: postID, token: UserToken)
        }
    }
    
    func TitleTapped(index: IndexPath) {
        let move = storyboard?.instantiateViewController(withIdentifier: "Brandcategories") as! Brandcategories
        navigationController?.pushViewController(move, animated: false)
    }
    
    
    func ShareTapped(index: IndexPath) {
//        // image to share
//        let image = UIImage(named: "Image")
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let imageToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func FollowTap(index: IndexPath) {
        CommonFuncs.AlertWithOK(msg: "Coming Soon", vc: self)
    }
    
    
    //MARK:>>>>> Like post api call
    func BrandPostLikeAPi(postId:String,index:IndexPath){
        let apiurl = ServerURL.firstpoint + ServerURL.brandlikePost
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")

        let params = ["token":UserToken, "id":postId, "vote":"u", "type":"1"] as [String:Any]
        print(params)

        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:brandlikePost) in
            print(response)

            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    DispatchQueue.main.async {
                        self.getBrandFeeds(count: self.brandlimit)
                    }
                }
            }
        }
    }
    
    
    //MARK:>>>>> Dislike the post
    
    func BrandPostDisLikeAPi(postId:String,index:IndexPath){
        let apiurl = ServerURL.firstpoint + ServerURL.brandlikePost
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let params = ["token":UserToken, "id":postId, "vote":"d", "type":"1"] as [String:Any]
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:barnddislikePost) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    DispatchQueue.main.async {
                        self.getBrandFeeds(count: self.brandlimit)
                    }
                }
            }
        }
    }
    
    
}
