//
//  Bookmarkvc.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class Bookmarkvc: UIViewController {
    
    

    @IBOutlet weak var tblview: UITableView!
    
    var Bookmarks = [getBookmarkdata]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
        getBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    
    @IBAction func backbtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
   
    //MARK:>>>> API CALL
    fileprivate func getBookmarks(){
       let uurl = ServerURL.firstpoint + ServerURL.getbookmarks
         guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken]
        networking.MakeRequest(Url: uurl, Param: params, vc: self) { (result:getBookmark) in
            print(result)
            if result.message == "success"{
                guard let response = result.data else {return}
                self.Bookmarks = response.map{$0}
                DispatchQueue.main.async {
                    self.tblview.reloadData()
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }
    

    deinit {
        print("Bookmarkvc removed")
    }
}

extension Bookmarkvc : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkcell") as! bookmarkcell
        cell.bookmarks = Bookmarks[indexPath.row]
        cell.myindexpath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
}

extension Bookmarkvc : bookmarkcellProtocol {
    
    func Unbookmark(index: IndexPath) {
        print("unbookmrk")
        guard let id = Bookmarks[index.row].id else {return}
        CommonFuncs.AlertWithActions(msg: "Are you sure you want to Unbookmark it ?", vc: self) {
            self.umbookmark_Apicall(postid: id)
        }
        
    }
    
    //MARK:>>>>>> Unbookmark api call
    fileprivate func umbookmark_Apicall(postid:String){
        let uurl = ServerURL.firstpoint + ServerURL.unbookmark
         guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken, "id":postid]
        networking.MakeRequest(Url: uurl, Param: params, vc: self) { (result:unbookmark) in
            print(result)
            if result.message == "success"{
                //successfully unbookmarked
                self.getBookmarks()
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }
    
}
