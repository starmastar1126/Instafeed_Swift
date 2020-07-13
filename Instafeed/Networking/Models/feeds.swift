//
//  feeds.swift
//  Instafeed
//
//  Created by gulam ali on 06/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation


struct postfeed:Decodable {
    var message:String
    var data:postfeedData?
}

struct postfeedData:Decodable{
    var news_id:Int?
}


struct postimage:Decodable {
    var message:String
    var data:postimageData?
}

struct postimageData:Decodable{
    var news_id:Int?
}



/*
 responseObject: {
 data =     {
 "news_id" = 28;
 };
 message = success;
 status = 200;
 }
 */


////google PlacesId model
//
//struct GoogleplaceID:Decodable {
//    var messege:String?
//}
//
//struct GoogleplaceIDdata:Decodable {
//    <#fields#>
//}
