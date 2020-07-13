//
//  Sidemenu.swift
//  Instafeed
//
//  Created by gulam ali on 09/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation

struct Profile:Decodable {
    var message:String?
    var data:Profiledata?
    
}

struct Profiledata:Decodable {
    var username:String?
    var profile_url:String?
    var email:String?
    var avatar:String?
    var first_name:String?
    var last_name:String?
    
}

/*
 {
 "status": 200,
 "message": "success",
 "data": {
 "user_id": "11",
 "username": "gulam",
 "profile_url": "http://13.234.116.90/profile/gulam",
 "email": "gulam@backstagesupporters.com",
 "avatar": "http://13.234.116.90/storage/avatar/200x200-",
 "first_name": "Gulam Ali",
 "middle_name": "",
 "last_name": "",
 "birth_date": "",
 "sex": "",
 "phone": "",
 "dt_added": "0000-00-00 00:00:00",
 "dt_modified": "0000-00-00 00:00:00",
 "status": "A",
 "group_id": "4",
 "email_verified": "0",
 "expired_at": "2019-08-10 02:55:39",
 "created_at": "2019-08-09 14:55:39",
 "updated_at": "2019-08-09 14:55:39",
 "location_id": "",
 "bank_name": "",
 "bank_acc_no": "",
 "bank_acc_type": "",
 "bank_ifsc_code": "",
 "city": "",
 "pincode": "",
 "address": "",
 "bio": "",
 "website": "",
 "lat": "0",
 "long": "0",
 "totals": {
 "total_news": "6",
 "total_issues": "0",
 "total_polls": "0",
 "total_blogs": "0",
 "total_followers": "0",
 "total_following": "0"
 }
 }
 }
 */
