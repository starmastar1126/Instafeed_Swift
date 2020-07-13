//
//  startnav.swift
//  Instafeed
//
//  Created by gulam ali on 18/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class startnav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       // view.backgroundColor = .white
      
    }
    
    
  
}

/*
 
 
 class MainNavigationController: UINavigationController {
 override func viewDidLoad() {
 super.viewDidLoad()
 view.backgroundColor = .white
 
 if isLoggedIn() {
 //assume user is logged in
 let homeController = HomeController()
 viewControllers = [homeController]
 } else {
 perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
 }
 }
 
 fileprivate func isLoggedIn() -> Bool {
 return UserDefaults.standard.isLoggedIn()
 }
 
 @objc func showLoginController() {
 let loginController = LoginController()
 present(loginController, animated: true, completion: {
 //perhaps we'll do something here later
 })
 }
 }
 
 
 */
