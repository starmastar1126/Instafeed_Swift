//
//  Articlescreen.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class Articlescreen: UIViewController {
    
    
    
    @IBOutlet weak var addcomment_btn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        addcomment_btn.layer.cornerRadius = 20.0
        addcomment_btn.GetBorder(border: 1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
