//
//  Internet-checker.swift
//  Instafeed
//
//  Created by gulam ali on 27/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import Alamofire

class connectivity{
    
    
    class var isconnectedToInternet:Bool{
        return NetworkReachabilityManager()?.isReachable ?? false

    }
    
}
