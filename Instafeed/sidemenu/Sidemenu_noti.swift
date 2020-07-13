//
//  Sidemenu_noti.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class Sidemenu_noti: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonActions(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 10:
            print("superstar and brand feeds")
            let move = storyboard?.instantiateViewController(withIdentifier: "superbrandsVC") as! superbrandsVC
            move.type = "brand"
            navigationController?.pushViewController(move, animated: false)
            
        case 20:
            print("back tap")
            navigationController?.popViewController(animated: false)
            
            
        case 30:
            print("citizen feed")
            let move = storyboard?.instantiateViewController(withIdentifier: "superbrandsVC") as! superbrandsVC
            move.type = "citizen"
            navigationController?.pushViewController(move, animated: false)
            
        case 40:
            print("following and followers")
            let move = storyboard?.instantiateViewController(withIdentifier: "sidefollowervc") as! sidefollowervc
            navigationController?.pushViewController(move, animated: false)
            
        case 50:
            print("email and sms")
            let move = storyboard?.instantiateViewController(withIdentifier: "sms") as! sms
            move.type = "sms"
            navigationController?.pushViewController(move, animated: false)
            
        case 60:
            print("from instafeed")
            
            let move = storyboard?.instantiateViewController(withIdentifier: "sms") as! sms
            move.type = "from instafeed"
            navigationController?.pushViewController(move, animated: false)
            
        default:
            break
        }
        
    }
    

}
