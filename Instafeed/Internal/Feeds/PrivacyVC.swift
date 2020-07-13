//
//  PrivacyVC.swift
//  Instafeed
//
//  Created by gulam ali on 23/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func buttonsActions(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 10: //
            print("back btn")
            navigationController?.popViewController(animated: true)
        default:
            break
        }
        
    }
    
    

    deinit {
        print("privacyvc removed")
    }
}
