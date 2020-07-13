//
//  networking.swift
//  mvvm
//
//  Created by gulam ali on 16/06/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
import CoreLocation


class networking: NSObject {
    

    class func SignUpUser(Url:String,Param:[String:Any],completion:@escaping (signup?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(signup.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                     ProgressHUD.dismiss()
                  completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                 ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
               completion(nil,err)
            }
            
        }
    }
    
    
    class func LoginUser(Url:String,Param:[String:Any],completion:@escaping (Login?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(Login.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                    ProgressHUD.dismiss()
                    completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    //forgot password
    
    class func forgotPassword(Url:String,Param:[String:Any],completion:@escaping (ForgotPassword?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(ForgotPassword.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                    ProgressHUD.dismiss()
                    completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    class func signInusingMobile(Url:String,Param:[String:Any],completion:@escaping (sendOTP?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(sendOTP.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                    ProgressHUD.dismiss()
                    completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    class func VerifyOTP(Url:String,Param:[String:Any],completion:@escaping (verifyOTP?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(verifyOTP.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                    ProgressHUD.dismiss()
                    completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    class func SocialLogin(Url:String,Param:[String:Any],completion:@escaping (socialLogin?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    do{
                        let data = try JSONDecoder().decode(socialLogin.self, from: closureResponse.data!)
                        print(data)
                        completion(data,nil)
                    }catch{
                        print("catched error in do try")
                        completion(nil,error)
                    }
                    
                }else{
                    print("values are nil")
                    ProgressHUD.dismiss()
                    completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    
    class func Citizentab_Recents(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (citizenRecents?, Error?)->()){
        
        if connectivity.isconnectedToInternet{
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            let data = try JSONDecoder().decode(citizenRecents.self, from: closureResponse.data!)
                            print(data)
                            completion(data,nil)
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                    
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    completion(nil,err)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
  
    }
    
    
    class func Citizentab_Feeds(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (citizenFeeds?, Error?)->()){
        
        if connectivity.isconnectedToInternet{
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            let data = try JSONDecoder().decode(citizenFeeds.self, from: closureResponse.data!)
                            print(data)
                            completion(data,nil)
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                    
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    completion(nil,err)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
        
      
    }
    
    
    class func MakeRequest<T: Decodable>(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (_ String: T) -> ()){
        
        if connectivity.isconnectedToInternet{
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            let data = try JSONDecoder().decode(T.self, from: closureResponse.data!)
                            print(data)
                            completion(data)
                        }catch{
                            print("catched error in do try")
                          //  completion(nil)
                            CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                            return
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                         CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                        return
                    }
                    
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
        
        
    }

    
    //MARK: - upload multiple photos
    
   class func uploadImagesAndData(Api:String,params:[String : Any]?,imagepost: UIImage, completion:@escaping (postimage?, Error?)->()) -> Void {
    
    ProgressHUD.show()
        let imageData1 = imagepost.jpegData(compressionQuality: 0.5)!
    
    print(params!)
    print(imageData1)
    
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }

            multipartFormData.append(imageData1, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            print("responseObject: \(value)")
                                            ProgressHUD.dismiss()
                                            do{
                                                let data = try JSONDecoder().decode(postimage.self, from: response.data!)
                                                print(data)
                                                completion(data,nil)
                                            }catch{
                                                print("catched error in do try")
                                                completion(nil,error)
                                            }
                                            
                                        case .failure(let responseError):
                                            ProgressHUD.dismiss()
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                ProgressHUD.dismiss()
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    
    
    
    //MARK:>>>>>> Send audio to server
    
    func uploadAudio(Api:String,params:[String : AnyObject]?,audio: URL, completionHandler:@escaping ()->()) -> Void {
        
       // let imageData1 = image1.jpegData(compressionQuality: 0.5)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
             multipartFormData.append(audio, withName: "file", fileName: "recording.m4a", mimeType: "audio/x-m4a")
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            print("responseObject: \(value)")
                                            completionHandler()
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    


}  // end of class






