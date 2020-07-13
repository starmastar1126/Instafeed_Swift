//
//  SignupVc.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SKCountryPicker
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class SignupVc: UIViewController {
    
   // @IBOutlet weak var countrypick: CountryPicker!
    
    @IBOutlet weak var signupother_view: UIView!
    @IBOutlet weak var signupemail_view: UIView!
    @IBOutlet weak var signupbtn_otlt: UIButton!
    @IBOutlet weak var SIGNuptext: UILabel!
    @IBOutlet weak var countryflag: UIImageView!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet weak var countrycode: UIButton!
    @IBOutlet weak var gmailbtn_otlt: UIButton!
    @IBOutlet weak var FBbtn_otlt: UIButton!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    var fb_userData = [String:Any]()
    var Gmail_userData = [String:Any]()
    
    let contryPickerController = CountryPickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        didloadSetup()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    //MARK:>>>> DIDload arrangements
    fileprivate func didloadSetup(){
         self.navigationController?.isNavigationBarHidden = false
        navigationBarSetup()
        signupother_view.isHidden = true
        SIGNuptext.text = "You can use any below methods\n to grant access to the app"
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentcontrol.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentcontrol.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentcontrol.layer.cornerRadius = 9.0
        segmentcontrol.layer.borderColor = UIColor.lightGray.cgColor
        segmentcontrol.layer.borderWidth = 1.0
        segmentcontrol.layer.masksToBounds = true
        
        
        let country = CountryManager.shared.currentCountry
        countrycode.setTitle(country?.dialingCode, for: .normal)
        countryflag.image = country?.flag
        countrycode.clipsToBounds = true
        
    }
    
    override func viewDidLayoutSubviews() {
        gmailbtn_otlt.layer.cornerRadius = gmailbtn_otlt.frame.height/2
        signupbtn_otlt.layer.cornerRadius = signupbtn_otlt.frame.height/2
        FBbtn_otlt.layer.cornerRadius = FBbtn_otlt.frame.height/2
    }
    
   
     //customise nav bar title.left bar item
    fileprivate func navigationBarSetup(){
        
     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
     self.navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.isTranslucent = true
     self.navigationController?.view.backgroundColor = UIColor.clear
     self.title = ""
     let btn1 = UIButton(type: .custom)
     btn1.setImage(UIImage(named: "back"), for: .normal)
     btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
     btn1.addTarget(self, action: #selector(tapSideMenu), for: .touchUpInside)
     let item1 = UIBarButtonItem(customView: btn1)
     self.navigationItem.leftBarButtonItem = item1
        
     }
    
    @objc func tapSideMenu(){
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func segmentTapped(_ sender: Any) {
        switch segmentcontrol.selectedSegmentIndex {
        case 0: // mail
            print("signup mail tapped")
            signupother_view.isHidden = true
            signupemail_view.isHidden = false
        
        case 1: // other
            print("other tapped")
            signupother_view.isHidden = false
            signupemail_view.isHidden = true
            
        default:
            break
        }
    }
    
    
    @IBAction func ButtonActions(_ sender: Any) {
        switch ((sender as AnyObject).tag) {
        case 10: // signupbtn
            print("signup tapped")
            checkFields()
        case 20: // fb btn
            print("fb tapped")
            handleFacebookLogin()
        case 30: //gmail
            print("gmail tap")
            GIDSignIn.sharedInstance().signIn()
        case 40: //login
            print("login tapped")
            self.navigationController?.popViewController(animated: false)
        default:
            break
        }

    }
    
    
    fileprivate func checkFields(){
        
        if fullname.text == ""{
         CommonFuncs.AlertWithOK(msg: "Full name is required", vc: self)
        }else if email.text == ""{
           CommonFuncs.AlertWithOK(msg: "Enail is required", vc: self)
        }else if mobile.text == "" {
         CommonFuncs.AlertWithOK(msg: "Mobile number is required", vc: self)
        }else if password.text == ""{
          CommonFuncs.AlertWithOK(msg: "Password is required", vc: self)
        }else{
            signUpuser()
        }

    }
    
    
    
    fileprivate func signUpuser(){
        let serverUrl:String = ServerURL.firstpoint+ServerURL.signup
        
        let parameters = ["first_name":fullname.text!, "email":email.text!, "mobile":mobile.text!, "device_id":"not now", "password":password.text!]
        
        networking.SignUpUser(Url: serverUrl, Param: parameters) { (data, err) in
            if err != nil{
                print("error encountered")
                return
            }
            
            if let response = data{
                print(response)
             //   print(response.data.error!)
                
                if response.message == "error"{
                    if response.data.error == "Email already exists"{
                        print("Email already exists")
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
                    // self.movetoMainAPP()
                }
            }
           
        }
        
    }
    
    
    @IBAction func countrycodeTAPPED(_ sender: Any) {
        
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) {[weak self] (country: Country) in
            self?.countryflag.image = country.flag
            self?.countrycode.setTitle(country.dialingCode, for: .normal)
            
        }
        // can customize the countryPicker here e.g font and color
        countryController.detailColor = UIColor.red
    }
    
    func movetoMainAPP(){
        let storyboard = UIStoryboard(name: "categoryStoryboard", bundle: nil)
        let move = storyboard.instantiateViewController(withIdentifier: "Mainpagevc") as! Mainpagevc
        self.present(move, animated: false, completion: nil)
    }
    
    //MARK:>>>> FB login
    
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
        print("signupvc removed")
    }

}

extension SignupVc : GIDSignInDelegate,GIDSignInUIDelegate{
    
    
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



