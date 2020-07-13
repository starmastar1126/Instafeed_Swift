//
//  plus.swift
//  Instafeed
//
//  Created by gulam ali on 12/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class plus: UIViewController {
    
    
    
    @IBOutlet weak var btntapped: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btntapped(_ sender: Any) {
        let story = UIStoryboard(name: "Feeds", bundle: nil)
        let move = story.instantiateViewController(withIdentifier: "Mainfeeds") as! Mainfeeds
        present(move, animated: true, completion: nil)
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
