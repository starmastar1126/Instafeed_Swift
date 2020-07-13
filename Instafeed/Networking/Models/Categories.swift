//
//  Categories.swift
//  Instafeed
//
//  Created by gulam ali on 05/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation

struct categorytab:Decodable{
    var message:String
    var data:[categorytabdata]?
}
struct categorytabdata:Decodable {
    var id:String?
    var name:String?
    var image:String?
    var description:String?
}





/*
 {
 "id": "14",
 "name": "Lifestyle",
 "description": "Lifestyle",
 "image": "http:\/\/13.234.116.90\/storage\/assets\/category.png"
 }
 */
