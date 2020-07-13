//
//  sideMenu.swift
//  Instafeed
//
//  Created by gulam ali on 05/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

class sideMenu: UIViewController {
    
   
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var usernme: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK:>>>> Get Profile
    fileprivate func getProfile(){
        let api = ServerURL.firstpoint + ServerURL.Getprofile
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken] as [String:Any]
        networking.MakeRequest(Url: api, Param: params, vc: self) { (result:Profile) in
            if result.message == "success"{
                guard let response = result.data else {return}
                
                DispatchQueue.main.async {
                    print(response)
                    self.usernme.text = "\(response.first_name!) \(response.last_name!)"
                    
                    self.profileimg.layer.cornerRadius = self.profileimg.frame.height/2
                    let profilephoto = URL(string: response.avatar ?? "")
                    let placeholder = UIImage(named: "proo")
                    self.profileimg.contentMode = .scaleAspectFill
                    self.profileimg.sd_setImage(with: profilephoto, placeholderImage: placeholder, options: .progressiveLoad, context: nil)
                }
                
                
            }else{
                CommonFuncs.AlertWithOK(msg: "Something went wrong while getting profile", vc: self)
                return
            }
        }
    }
    
    

    @IBAction func profiletapped(_ sender: Any) {
        let story = UIStoryboard(name: "categoryStoryboard", bundle: nil)
        let move = story.instantiateViewController(withIdentifier: "CitizenProfile") as! CitizenProfile
        navigationController?.pushViewController(move, animated: false)
    }
    
    
    
    @IBAction func settingsTapped(_ sender: Any) {
        let move = storyboard?.instantiateViewController(withIdentifier: "Settings") as! Settings
        move.username = "\(usernme.text!)"
        navigationController?.pushViewController(move, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
   
    deinit {
        print("sidemenu removed")
    }
    


}
