//
//  SocialLogins.swift
//  Instafeed
//
//  Created by gulam ali on 19/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class socialLogins:NSObject{
    
    
    class func LoginWithFB(vc:UIViewController) -> NSDictionary{
       
        var userData:NSDictionary!
        let fbLoginManager : LoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: vc) { (result, error) in
            
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((AccessToken.current) != nil){
                            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    let dict: NSDictionary = result as! NSDictionary
                                    userData = dict
                                    if let user : NSString = dict.object(forKey:"name") as! NSString? {
                                        print("user: \(user)")
                                    }
                                    if let id : NSString = dict.object(forKey:"id") as? NSString {
                                        print("id: \(id)")
                                    }
                                    if let email : NSString = (result! as AnyObject).value(forKey: "email") as? NSString {
                                        print("email: \(email)")
                                    }
                                    if let fname : NSString = (result! as AnyObject).value(forKey: "first_name") as? NSString {
                                        print("first_name: \(fname)")
                                    }
                                    if let lname : NSString = (result! as AnyObject).value(forKey: "last_name") as? NSString {
                                        print("last_name: \(lname)")
                                    }
                                    
                                }else{
                                    print("error while getting the fb login ayan")
                                }
                            })
                        }
                    }
                }
            }
        }

        return userData
        
    }
    
}


/*
 
 fileprivate func handleFacebookLogin(){
 
 let fbLoginManager : LoginManager = LoginManager()
 
 fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
 
 if (error == nil){
 let fbloginresult : LoginManagerLoginResult = result!
 if fbloginresult.grantedPermissions != nil {
 if(fbloginresult.grantedPermissions.contains("email")) {
 if((AccessToken.current) != nil){
 GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
 if (error == nil){
 let dict: NSDictionary = result as! NSDictionary
 
 if let user : NSString = dict.object(forKey:"name") as! NSString? {
 print("user: \(user)")
 }
 if let id : NSString = dict.object(forKey:"id") as? NSString {
 print("id: \(id)")
 }
 if let email : NSString = (result! as AnyObject).value(forKey: "email") as? NSString {
 print("email: \(email)")
 }
 if let fname : NSString = (result! as AnyObject).value(forKey: "first_name") as? NSString {
 print("first_name: \(fname)")
 }
 if let lname : NSString = (result! as AnyObject).value(forKey: "last_name") as? NSString {
 print("last_name: \(lname)")
 }
 
 }else{
 print("error while getting the fb login ayan")
 }
 })
 }
 }
 }
 }
 }
 
 
 
 
 }
 */
