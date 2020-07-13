//
//  followcontacts.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import CarbonKit

class followcontacts: UIViewController {
    
    
    @IBOutlet weak var topbar: UIView!
    
    let bars = ["SUGGESTED","CONTACTS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabswipe = CarbonTabSwipeNavigation(items: bars, delegate: self)
        tabswipe.setIndicatorColor(UIColor(hexValue: InstafeedColors.ThemeOrange))  //orange
        tabswipe.setSelectedColor(UIColor(hexValue: InstafeedColors.ThemeOrange))
        tabswipe.tabBarItem.badgeColor = UIColor.white
        tabswipe.setNormalColor(UIColor.lightGray)
        tabswipe.setTabBarHeight(60.0)
        tabswipe.setTabExtraWidth(topbar.frame.width/4)
        tabswipe.insert(intoRootViewController: self, andTargetView: topbar)
    }
    
    
    
    @IBAction func backtapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    
    
    

   
}


extension followcontacts: CarbonTabSwipeNavigationDelegate{
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        guard let storyboard = storyboard else { return UIViewController() }
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "contacts")
        }else{
           return storyboard.instantiateViewController(withIdentifier: "suggested")
        }
        
    }
    
    
    
    
}
