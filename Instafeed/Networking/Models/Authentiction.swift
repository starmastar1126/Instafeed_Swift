//
//  Authentiction.swift
//  Instafeed
//
//  Created by gulam ali on 19/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation

//for sign up
struct signup:Decodable {
    var message:String
    var data:signupData
}

struct signupData : Decodable{
    var token : String?
    var error:String?
}



//for Login
struct Login : Decodable {
    var message:String
    var data:Logindata
}
struct Logindata : Decodable{
    var token : String?
    var error:String?
}



//forgot password
struct ForgotPassword:Decodable {
    var message:String
    var data:forgotPasswordData
}
struct forgotPasswordData:Decodable {
    var user_id:String?
    var message:String?
}




//signIn using Mobile
struct sendOTP:Decodable {
    var message:String
    var data:sendOTPData
}
struct sendOTPData:Decodable {
    var mobile:String?
    var otp:String?
    var message:String?
}




//Verify OTP
struct verifyOTP:Decodable {
    var message:String
    var data:verifyOTPData?
}
struct verifyOTPData:Decodable {
    var mobile:String?
    var otp:String?
    var is_verified:String?
    var user_id:Int?
    var token:String?
    var username:String?
}



//socialLogin
struct socialLogin:Decodable {
    var message:String
    var data:socialLoginData?
}
struct socialLoginData:Decodable {
    //var user_id:String?
    var token:String?
    
}


//Change Password
/*
 
 {
 "status": 400,
 "message": "success",
 "data": {
 "user_id": "1234",
 "message": "Password successfully reset"
 }
 }
 
 */

struct changePassword:Decodable {
    var message:String
    var data:changePasswordData?
}
struct changePasswordData:Decodable {
    var user_id:String?
    var message:String?
    
}





struct bigchunk : Decodable {
    
    struct changePasswod:Decodable {
        var message:String
        var data:changePasswordData?
    }
    struct changePaswordData:Decodable {
        var user_id:String?
        var message:String?
        
    }

    
    
    
}
