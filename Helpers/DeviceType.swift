//
//  DeviceType.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import UIKit

//fix for iphoneX
struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    static let maxWH = max(ScreenSize.width, ScreenSize.height)
}


struct DeviceType {
    static let iPhone4orLess  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH <  568.0
    static let iPhone5orSE    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 568.0
    static let iPhone678      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 667.0
    static let iPhone678p     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 736.0
    static let iPhoneX        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 812.0
}
