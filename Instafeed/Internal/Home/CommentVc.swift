//
//  CommentVc.swift
//  Instafeed
//
//  Created by gulam ali on 31/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class CommentVc: UIViewController {
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var commenttxtview: UITextView!
    @IBOutlet weak var commentbox: UIView!
    
    
    var TabType = ""
    var brandFeeddata : brandfeedsData!
    var citizendata : citizenFeedsData!
    var CitizenCommentList = [citizenCommentListdata]()
    var brandcommentList = [brandCommentListdata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(brandFeeddata)
        tblview.delegate = self
        tblview.dataSource = self
        tblview.rowHeight = UITableView.automaticDimension
        tblview.estimatedRowHeight = 200
        
        
       commentbox.layer.borderColor = UIColor.orange.cgColor
        commentbox.layer.borderWidth = 1
        commentbox.layer.cornerRadius = commentbox.frame.height/2
        
        commenttxtview.font = UIFont.preferredFont(forTextStyle: .headline)
        commenttxtview.delegate = self
       // commenttxtview.isScrollEnabled = false
        commenttxtview.text = "Comment as Gulam Ali"
        commenttxtview.textColor = UIColor.lightGray
        
        callList()
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        tabBarController?.tabBar.isHidden = true
    }

    @IBAction func backbtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    
    func callList(){
        if TabType == "citizen"{
            //citizendata
            guard let data = citizendata else {return}
            let id = data.id
            guard let postid = id else {return}
            getCommentList(postId: postid)
        }else{
            guard let data = brandFeeddata else {return}
            let id = data.id
            guard let postid = id else {return}
            BrandgetCommentList(postId: postid)
        }
    }
    
    //MARK:>>>>> Citizen Comment List
    fileprivate func getCommentList(postId:String){
        let apiurl = ServerURL.firstpoint + ServerURL.citizenCommentList
        let params = ["id":postId] as [String:Any]
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (result:citizenCommentList) in
            print(result.message)
            
            if result.message == "success"{
                if let response = result.data{
                    print(response)
                    self.CitizenCommentList = response.map{$0}
                    print("your array -> \(self.CitizenCommentList)")
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
    
    
    //MARK:>>>>> Brand Comment List
    fileprivate func BrandgetCommentList(postId:String){
        let apiurl = ServerURL.firstpoint + ServerURL.brandCommentList
        let params = ["id":postId] as [String:Any]
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (result:brandCommentList) in
            print(result.message)
            
            if result.message == "success"{
                if let response = result.data{
                    print(response)
                    self.brandcommentList = response.map{$0}
                    print("your array -> \(self.brandcommentList)")
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
    
    
    //MARK:>>>> Add comment in brand tab
    
    fileprivate func Addcomment_Brand(postID:String){
        let api = ServerURL.firstpoint + ServerURL.brandaddcomment
         guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken,"id":postID,"comment":commenttxtview.text!] as [String:Any]
        
        networking.MakeRequest(Url: api, Param: params, vc: self) { (result:addcommentBRAND) in
            print(result.message)
            
            if result.message == "success"{
                if let response = result.data{
                    guard let staus = response.status else {return}
                    if staus == "A"{
                        //comment successfully addded
                        self.commenttxtview.text = ""
                        self.BrandgetCommentList(postId: postID)
                    }else{
                        print("else cased")
                        return
                    }
                    
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }
    
    
    //MARK:>>>> Add comment in citizen tab
    
    fileprivate func Addcomment_Citizen(postID:String){
        let api = ServerURL.firstpoint + ServerURL.citizenAddComment
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken,"id":postID,"comment":commenttxtview.text!] as [String:Any]
        
        networking.MakeRequest(Url: api, Param: params, vc: self) { (result:addcommentCITIZEN) in
            print(result.message)
            
            if result.message == "success"{
                if let response = result.data{
                    guard let staus = response.status else {return}
                    if staus == "A"{
                        //comment successfully addded
                        self.commenttxtview.text = ""
                        self.getCommentList(postId: postID)
                    }else{
                        print("else cased")
                        return
                    }
                    
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }
    
    
    func getParams_brandfeeds(){
       // print(brandFeeddata)
        guard let data = brandFeeddata else {return}
        let id = data.id
        guard let postid = id else {return}
        Addcomment_Brand(postID: postid)
    }
    
    
    func getParams_citizenfeeds(){
        guard let data = citizendata else {return}
        let id = data.id
        guard let postid = id else {return}
        Addcomment_Citizen(postID: postid)
    }
    
    
    @IBAction func postComment(_ sender: Any) {
        if commenttxtview.text == "" || commenttxtview.text == "Comment as Gulam Ali"{
          //show alert
            CommonFuncs.AlertWithOK(msg: "Write a comment to post", vc: self)
            return
        }else{
            if TabType == "citizen"{
                getParams_citizenfeeds()
            }else{
               getParams_brandfeeds()
            }
        }
    }
    
    
    
    
    deinit {
        print("commentvc removed")
    }
    
}

extension CommentVc : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if TabType == "citizen"{
            return CitizenCommentList.count
        }else{
            return brandcommentList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if TabType == "citizen"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCell
            cell.citizenlist = CitizenCommentList[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCell
            cell.brandlist = brandcommentList[indexPath.row]
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
}


extension CommentVc : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Comment as Gulam Ali"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
