//
//  OTPvc.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SKCountryPicker

class OTPvc: UIViewController {
    
    @IBOutlet weak var headingText: UILabel!
    @IBOutlet weak var otptxt: UITextField!
    @IBOutlet weak var otpview: UIView!
    @IBOutlet weak var mobileview: UIView!
    //@IBOutlet weak var otpview: UIView!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var flagcode: UIButton!
    @IBOutlet weak var flagimage: UIImageView!
    @IBOutlet weak var verifynowbtn: UIButton!
    @IBOutlet weak var backbtn_otlt: UIButton!
    @IBOutlet weak var nextbtn_otlt: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpview.isHidden = true
        mobileview.isHidden = false
        headingText.text = "We just sent to you a code\n usually arrives fast..."
        otpview.layer.cornerRadius = 25.0
       // backbtn_otlt.layer.cornerRadius = 25.0
        backbtn_otlt.GetBorder(border: 0.5)
        nextbtn_otlt.getShadow()
        verifynowbtn.getShadow()
        
        let country = CountryManager.shared.currentCountry
        flagcode.setTitle(country?.dialingCode, for: .normal)
        flagimage.image = country?.flag
        flagcode.clipsToBounds = true
    }
    
    
    override func viewDidLayoutSubviews() {
        backbtn_otlt.layer.cornerRadius = backbtn_otlt.frame.height/2
         nextbtn_otlt.layer.cornerRadius =  nextbtn_otlt.frame.height/2
       verifynowbtn.layer.cornerRadius = verifynowbtn.frame.height/2
    }
    
    
    
    @IBAction func buttonActions(_ sender: Any) {
        switch ((sender as AnyObject).tag) {
        case 10: //please again
            print("please again")
            
        case 20: //back btn
            print("back btn tap")
            self.navigationController?.popViewController(animated: false)
        case 30: //nextbtn
            print("next tapp")
            handleOTP_verify()
            
            
        case 90: // verify mobile num
            print("verify number tap")
            handleSendOtp()
        default:
            break
        }
    }
    
    
    @IBAction func flagcode_tapped(_ sender: Any) {
        
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) {[weak self] (country: Country) in
            self?.flagimage.image = country.flag
            self?.flagcode.setTitle(country.dialingCode, for: .normal)
            
        }
        // can customize the countryPicker here e.g font and color
        countryController.detailColor = UIColor.red
    }
    
    
    func handleSendOtp(){
        if mobile.text == ""{
            CommonFuncs.AlertWithOK(msg: "Please fill your mobile number", vc: self)
        }else{
           sendOTP()
        }
    }
    
    fileprivate func sendOTP(){
        let serverURL = ServerURL.firstpoint + ServerURL.sendOTP
        let params = ["mobile":mobile.text!, "password":"123456"]
        networking.signInusingMobile(Url: serverURL, Param: params) { (data, err) in
            if err != nil{
                CommonFuncs.AlertWithOK(msg: "Something went wrong, Try again later", vc: self)
                return
            }
            
            if let response = data {
                let msg = response.message
                if msg == "success"{
                    self.mobileview.isHidden = true
                    self.otpview.isHidden = false
                }else{
                    let msg = response.data.message!
                    CommonFuncs.AlertWithOK(msg: "\(msg)", vc: self)
                }
            }
            
        }
    }
    
    
    func handleOTP_verify(){
        if otptxt.text == ""{
            CommonFuncs.AlertWithOK(msg: "Please fill the OTP you have received", vc: self)
        }else{
            VerifyOtp()
        }
    }
    
    fileprivate func VerifyOtp(){
        let serverURL = ServerURL.firstpoint + ServerURL.VerifyOTP
        let params = ["mobile":mobile.text! , "otp":otptxt.text!]
        networking.VerifyOTP(Url: serverURL, Param: params) { (data, err) in
            if err != nil {
                return
            }
            
            if let response = data{
                let msg = response.message

                if msg == "success"{

                    if let responsedata = response.data{
                        let token = responsedata.token!
                        UserDefaults.standard.saveToken(token: token)
                        UserDefaults.standard.userLoggedIn(value: true)
                        self.moveintomainAPP()
                    }else{
                        print("")
                    }


                }else{
                    CommonFuncs.AlertWithOK(msg: "Something went wrong, Please check the OTP you have typed", vc: self)
                }
            }
            
        }
    }
    
    
    func moveintomainAPP(){
        let storyboard = UIStoryboard(name: "categoryStoryboard", bundle: nil)
        let move = storyboard.instantiateViewController(withIdentifier: "Mainpagevc") as! Mainpagevc
        self.present(move, animated: false, completion: nil)
        //here dont forget to remove all the authentication controllers from nav stac
    }
    
    
    @IBAction func backtapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: false)
        
    }
    

    
    deinit {
        print("otpvc removed")
    }
    
}
