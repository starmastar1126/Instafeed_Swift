//
//  Brandcategories.swift
//  Instafeed
//
//  Created by gulam ali on 10/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import CarbonKit
import SDWebImage

class Brandcategories: UIViewController {
    
    
    @IBOutlet weak var headtitle: UILabel!
    
    @IBOutlet weak var profilephoto: UIImageView!
    @IBOutlet weak var tabsView: UIView!
    
    
    var BrandCategories = [brandTitletapdata]()
    var TabNames = ["All Categories"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = true
//        navigationBarSetup()
//        tabMenusetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationBarSetup()
        tabMenusetup()
        
    }
    
    //customise nav bar title.left bar item
    fileprivate func navigationBarSetup(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.title = ""
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "orangeback"), for: .normal)
        btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(tapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        
    }
    
    fileprivate func tabMenusetup(){
        GetCategories()
    }
    
    @objc func tapSideMenu(){
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    //MARK:>>>> Api call
    fileprivate func GetCategories(){
        let apiurl = ServerURL.firstpoint + ServerURL.brandTitletap
        networking.MakeRequest(Url: apiurl, Param: nil, vc: self) { (result:brandTitletap) in
            print(result)
            if result.message == "success"{
                if let response = result.data{
                    self.BrandCategories = response.map{$0}
                    DispatchQueue.main.async {
                        for names in self.BrandCategories{
                            guard let tab = names.name else {return}
                            self.TabNames.append(tab)
                           
                        }
                        let tabswipe = CarbonTabSwipeNavigation(items: self.TabNames, delegate: self)
                        tabswipe.setIndicatorColor(UIColor(hexValue: InstafeedColors.ThemeOrange))  //orange
                        tabswipe.setSelectedColor(UIColor(hexValue: InstafeedColors.ThemeOrange))
                        tabswipe.tabBarItem.badgeColor = UIColor.white
                        tabswipe.setNormalColor(UIColor.lightGray)
                        tabswipe.setTabBarHeight(60.0)
                        tabswipe.setTabExtraWidth(50.0)
                        tabswipe.insert(intoRootViewController: self, andTargetView: self.tabsView)
                    }
                }
            }else{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }
        }
    }
    
    
    deinit {
        print("brand categories removed")
    }
    

}


extension Brandcategories: CarbonTabSwipeNavigationDelegate{
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        guard let storyboard = storyboard else { return UIViewController() }
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "allcategories")
        }else if index == 1{
            return storyboard.instantiateViewController(withIdentifier: "home")
        }else if index == 2{
            return storyboard.instantiateViewController(withIdentifier: "politics")
        }else if index == 3{
            return storyboard.instantiateViewController(withIdentifier: "entertainment")
        }else {
            return storyboard.instantiateViewController(withIdentifier: "world")
        }
        
    }
    
    
    
    
}
