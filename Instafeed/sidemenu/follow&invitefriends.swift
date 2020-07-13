//
//  follow&invitefriends.swift
//  Instafeed
//
//  Created by gulam ali on 14/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class follow_invitefriends: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func buttonsTapped(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
        case 10:
            print("follow contacts")
            let move = storyboard?.instantiateViewController(withIdentifier: "followcontacts") as! followcontacts
            navigationController?.pushViewController(move, animated: false)
            
        case 20:
            print("back tap")
            navigationController?.popViewController(animated: false)
        default:
            break
        }
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
