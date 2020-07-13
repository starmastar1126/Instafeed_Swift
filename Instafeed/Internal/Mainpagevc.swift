//
//  Mainpagevc.swift
//  Instafeed
//
//  Created by gulam ali on 09/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class Mainpagevc: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
     // UserDefaults.standard.userLoggedIn(value: false)
    }
    
    
    
    //MARK:>>>>> Navigationbar setup
    fileprivate func navigationBarSetup(){
        
         self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.title = "Home"

//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "System", size: 20)!]
        
        
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Regular", size: 30)]
//        UINavigationBar.appearance().titleTextAttributes = attributes
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "orangeback"), for: .normal)
        btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(BackTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        
    }
    
    @objc func BackTapped(){
       // self.navigationController?.popViewController(animated: false)
    }
    
    
    deinit {
        print("mainvc removed")
    }

   

}
