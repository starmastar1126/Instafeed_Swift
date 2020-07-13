//
//  ViewController.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Signintext: UILabel!
    @IBOutlet weak var signin_other_view: UIView!
    @IBOutlet weak var Signin_mail_view: UIView!
    @IBOutlet weak var loginbtn_otlt: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var Phonebtn_tlt: UIButton!
    @IBOutlet weak var facebookbtn_otlt: UIButton!
    @IBOutlet weak var gmailbtn_otlt: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var fb_userData = [String:Any]()
    var Gmail_userData = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        didloadSetup()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        signin_other_view.isHidden = true
//        Signin_mail_view.isHidden = false
        
    }

    //MARK:>>> uiarrangement in didload
    fileprivate func didloadSetup(){
        
        self.navigationController?.isNavigationBarHidden = true
        Signintext.text = "You can use any below methods\n to grant access to the app"
        signin_other_view.isHidden = true
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentControl.layer.cornerRadius = 9.0
        segmentControl.layer.borderColor = UIColor.lightGray.cgColor
        segmentControl.layer.borderWidth = 1.0
        segmentControl.layer.masksToBounds = true
        
        loginbtn_otlt.getShadow()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        loginbtn_otlt.layer.cornerRadius = loginbtn_otlt.frame.height/2
        Phonebtn_tlt.layer.cornerRadius = Phonebtn_tlt.frame.height/2
        facebookbtn_otlt.layer.cornerRadius = facebookbtn_otlt.frame.height/2
         gmailbtn_otlt.layer.cornerRadius = gmailbtn_otlt.frame.height/2
    }
    
    
    @IBAction func segmentTapped(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            print("mail tapped")
            signin_other_view.isHidden = true
            Signin_mail_view.isHidden = false
        case 1:
             print("other tapped")
             signin_other_view.isHidden = false
             Signin_mail_view.isHidden = true
        default:
            break
        }
        
    }
    
    
    @IBAction func ButtonActions(_ sender: Any) {
       
        switch ((sender as AnyObject).tag) {
        case 10: // login btn
            print("login btn tapped")
            handleLogin()
        case 20: // forgot password
            print("forgot passwrd")
             handleforgetPassword()
        case 30: // phonebtn
            print("phonebtn")
            let move = storyboard?.instantiateViewController(withIdentifier: "OTPvc") as! OTPvc
            self.navigationController?.pushViewController(move, animated: false)
        case 40: // fb btn
            print("fb btn taped")
            handleFacebookLogin()
            
        case 50: //gmail btn
            print("gmail btn tapped")
            LoginwithGOOGLE()
            
        case 60: //create account
            print("create account tapped")
            let move = storyboard?.instantiateViewController(withIdentifier: "SignupVc") as! SignupVc
            self.navigationController?.pushViewController(move, animated: false)
        default:
            break
        }
        
    }
    
    
    func handleLogin(){
        if email.text == ""{
            CommonFuncs.AlertWithOK(msg: "Email is required", vc: self)
        }else if password.text == ""{
            CommonFuncs.AlertWithOK(msg: "Password is required", vc: self)
        }else{
            loginUser()
        }
    }
    
    //MARK:>>>> APi call
    fileprivate func loginUser(){
        
        let serverURL = ServerURL.firstpoint + ServerURL.login
        let params = ["email":email.text!, "password":password.text!, "device_id":"not now"]
        
//        networking.LoginUser(Url: serverURL, Param: params) { (data, err) in
//            if err != nil{
//                CommonFuncs.AlertWithOK(msg: "Something went wrong at our side,Please try again later", vc: self)
//                return
//            }
//
//            if let response = data{
//                print(response)
//
//
//                if response.message == "error"{
//                    if response.data.error == "Incorrect User Name Or Password"{
//                        print("Incorrect User Name Or Password")
//                        let err = response.data.error!
//                        CommonFuncs.AlertWithOK(msg: "\(err)", vc: self)
//                        return
//                    }else{
//                        print(response.data.error!)
//                    }
//                }else{
//                    print(response.data.token!)
//                    let token = response.data.token!
//                    UserDefaults.standard.saveToken(token: token)
//                    UserDefaults.standard.userLoggedIn(value: true)
//                    self.movetoMainAPP()
//                }
//
//
//            }
//        }
        
        
        networking.MakeRequest(Url: serverURL, Param: params, vc: self) { (response:Login) in
            print(response)
            if response.message == "error"{
                if response.data.error == "Incorrect User Name Or Password"{
                    print("Incorrect User Name Or Password")
                    let err = response.data.error!
                    CommonFuncs.AlertWithOK(msg: "\(err)", vc: self)
                    return
                }else{
                    print(response.data.error!)
                }
            }else{
                print(response.data.token!)
                let token = response.data.token!
                UserDefaults.standard.saveToken(token: token)
                UserDefaults.standard.userLoggedIn(value: true)
                self.movetoMainAPP()
            }
        }
     
    }
    
    
    func movetoMainAPP(){
        let storyboard = UIStoryboard(name: "categoryStoryboard", bundle: nil)
        let move = storyboard.instantiateViewController(withIdentifier: "Mainpagevc") as! Mainpagevc
        self.present(move, animated: false, completion: nil)
    }
    
    func handleforgetPassword(){
        if email.text == ""{
            CommonFuncs.AlertWithOK(msg: "Email is mandatory to set up your new password", vc: self)
        }else{
            forgetPasswordCall()
        }
    }
    
    //MARK:>>> FORGET PASSWORD CALL
    fileprivate func forgetPasswordCall(){
        let serverURL = ServerURL.firstpoint + ServerURL.forgetPassword
        let param = ["email":email.text!]
        networking.forgotPassword(Url: serverURL, Param: param) { (data, err) in
            if err != nil{
                CommonFuncs.AlertWithOK(msg: "Something went wrong at our side,Please try again later", vc: self)
                return
            }
            
            if let response = data{
                let msg = response.data.message!
                CommonFuncs.AlertWithOK(msg: "\(msg)", vc: self)
            }
            
        }
    }
    
    
    fileprivate func handleFacebookLogin(){
        
        let fbLoginManager : LoginManager = LoginManager()

        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) {[weak self] (result, error) in

            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((AccessToken.current) != nil){
                            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    
                                   // print(AccessToken.current?.tokenString)
                                    let token = AccessToken.current?.tokenString
                                    self?.fb_userData["token"] = token
                                    let dict: NSDictionary = result as! NSDictionary

                                    if let user : NSString = dict.object(forKey:"name") as! NSString? {
                                        print("user: \(user)")
                                        self?.fb_userData["name"] = user
                                    }
                                    if let id : NSString = dict.object(forKey:"id") as? NSString {
                                        print("id: \(id)")
                                        self?.fb_userData["id"] = id
                                    }
                                    if let email : NSString = (result! as AnyObject).value(forKey: "email") as? NSString {
                                        print("email: \(email)")
                                        self?.fb_userData["email"] = email
                                    }
                                    if let fname : NSString = (result! as AnyObject).value(forKey: "first_name") as? NSString {
                                        print("first_name: \(fname)")
                                        self?.fb_userData["first_name"] = fname
                                    }
                                    if let lname : NSString = (result! as AnyObject).value(forKey: "last_name") as? NSString {
                                        print("last_name: \(lname)")
                                        self?.fb_userData["last_name"] = lname
                                    }
                                    print("move into app")
                                    self?.socialLogin_APIcall(provider:"facebook", DataDict: self?.fb_userData ?? ["":""])
                                    
                                }else{
                                    print("error while getting the fb login ayan")
                                }
                            })
                        }
                    }
                }
            }
        }
    
//        let data = socialLogins.LoginWithFB(vc: self)
//        print(data)
        
    }
    
    
    fileprivate func LoginwithGOOGLE(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:>>>>>> API call
    fileprivate func socialLogin_APIcall(provider:String, DataDict:[String:Any]){
        
        let serverURL = ServerURL.firstpoint + ServerURL.socialLogin
      
        print(DataDict)
         let fname = DataDict["first_name"] as! String
          let lname = DataDict["last_name"] as! String
         let token = DataDict["token"] as! String
        let email = DataDict["email"] as! String

        
        let params = ["social_id":token, "provider_id":provider, "first_name":fname, "last_name":lname, "email":email, "phone":"", "password":""]
        print(params)
        
        networking.SocialLogin(Url: serverURL, Param: params) { (data, err) in
            if err != nil{
                CommonFuncs.AlertWithOK(msg: "Something went wrong", vc: self)
                return
            }
            if let response = data{
                print(response.message)
                let msg = response.message
                if msg == "success"{
                    if let data = response.data{
                       // print(data.token)
                        guard let tokrn = data.token else {return}
                        UserDefaults.standard.saveToken(token: tokrn)
                        UserDefaults.standard.userLoggedIn(value: true)
                        self.movetoMainAPP()
                    }
                }
                
            }
            
        }
    }
    
    
    
    deinit {
        print("viewcontroller removed")
    }
    

}

extension ViewController : GIDSignInDelegate,GIDSignInUIDelegate{
    
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                     withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
           // let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            print(fullName!)
            print(givenName!)
            print(familyName!)
            print("this is google token -> \(idToken)")
            print("ayan google signin mail is ->\(email!)")
            
            Gmail_userData["first_name"] = givenName!
            Gmail_userData["last_name"] = familyName!
            Gmail_userData["token"] = idToken!
            Gmail_userData["email"] = email!
            
            self.socialLogin_APIcall(provider: "google", DataDict: Gmail_userData)
            
        } else {
            print("\(error!)")
        }
    
}

}

