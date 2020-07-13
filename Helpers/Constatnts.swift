//
//  Constatnts.swift
//  Instafeed
//
//  Created by gulam ali on 19/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import UIKit


struct constnt {
    
    static let fbApp_id:String = "478526966242222"
    static let Google_key:String = "569566651528-pvkpiosavf3kb6spoai8fbismiqo43d5.apps.googleusercontent.com"
    
    static let googleMapsKey = "AIzaSyC3haQgdTlH8QxAo7OsB6szbXghIqsZT3c"
//AIzaSyC3haQgdTlH8QxAo7OsB6szbXghIqsZT3c
    
  static let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
}

struct Alertmsg {
    static let wentwrong:String = "Something went wrong,Try again later"
}

struct ServerURL {
    
    static let firstpoint:String = "http://13.234.116.90/api/"
    
    //MARK:>>>>>> endpoints
    
    //Authentication
    static let signup:String = "signup"
    static let login:String = "login"
    static let forgetPassword = "forgot"
    static let sendOTP = "signup/otp"
    static let VerifyOTP = "signup/otp/verify"
    static let socialLogin = "social"
    static let changePassword = "change_password"
    
    
    //Home Tab Bar
    
    //citizen top tab
    static let citizenRecents:String = "citizen/recents"
    static let likepost:String = "citizen/vote"
    static let citizenAddComment = "citizen/comment"
    static let citizenCommentList = "citizen/comments"
    
    
    
    
//    //Brand top tab
    static let brandlikePost = "brands/vote"
    static let brandDislikePost = "brands/vote"
    static let brandaddcomment = "brands/comment"
    static let brandCommentList = "brands/comments"
    static let brandTitletap = "brands/category"
    
    
    // BookMark
    static let addBookmark = "bookmark"
    static let getbookmarks = "getbookmarks"
    static let unbookmark = "unbookmark"
    
    
    //Category tab
    static let categoryTab = "news/category"
    
    
    //feeds post
    static let feedPost = "citizen/post"
    
    //user profile
    static let Getprofile = "profile"
    
}
