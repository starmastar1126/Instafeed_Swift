//
//  LocationVC.swift
//  Instafeed
//
//  Created by gulam ali on 23/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class LocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func buttonstapped(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 10: //
            print("cross tapped")
            navigationController?.popViewController(animated: true)
        default:
            break
        }
        
        
    }
    
    

    deinit {
        print("locationvc removed")
    }

}
