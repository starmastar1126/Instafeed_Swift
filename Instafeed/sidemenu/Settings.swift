//
//  Settings.swift
//  Instafeed
//
//  Created by gulam ali on 09/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    @IBOutlet weak var logoutbtn_otlt: UIButton!
    
    var username = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logoutbtn_otlt.setTitle("Log out \(username)", for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func backtapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        print("logout tapped")
        UserDefaults.standard.userLoggedIn(value: false)
        //remove all the vc's
        navigationController?.viewControllers.removeAll()
        constnt.appDelegate.rootlogin()
    }
    
    
    
    @IBAction func buttons_actions(_ sender: Any) {
        switch ((sender as AnyObject).tag) {
        case 10:
            print("follow and invite")
            let move = storyboard?.instantiateViewController(withIdentifier: "follow_invitefriends") as! follow_invitefriends
            navigationController?.pushViewController(move, animated: false)
            
        case 20:
            print("notifications")
            let move = storyboard?.instantiateViewController(withIdentifier: "Sidemenu_noti") as! Sidemenu_noti
            navigationController?.pushViewController(move, animated: false)
        default:
            break
        }
    }
    
    
   
    
    
    deinit {
        print("settings removed")
    }

}
