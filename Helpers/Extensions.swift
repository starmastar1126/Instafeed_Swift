//
//  Extensions.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import UIKit



//MARK:>>>>> Userdefaults

extension UserDefaults{
    
    func saveToken(token:String){
       // set(bool, forKey: "TokenCheck")
        set(token, forKey: "SavedToken")
        synchronize()
    }
    
    func saveData(data:Any, key:String){
        set(data, forKey: key)
        synchronize()
    }
    
    func userLoggedIn(value:Bool){
        set(value, forKey: "UserLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool{
        return bool(forKey: "UserLoggedIn")
    }
    
    
}

//MARK:>>>>>>>>> UIBUTTON Extension

extension UIButton {
    
    func getShadow(){
//        globeButton.setImage(UIImage(named: "Globe"), forState: .Normal)
//        globeButton.backgroundColor = UIColor(red: 171/255, green: 178/255, blue: 186/255, alpha: 1.0)
        
        // Shadow and Radius
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
       // self.layer.cornerRadius = corners
    }
    
    func RoundCorners(corners:CGFloat){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = corners
    }
    
    func GetBorder(border:CGFloat){
        
       self.layer.borderWidth = border
        self.layer.borderColor = UIColor.lightGray.cgColor
        //UIColor(red: 228, green: 245, blue: 254, alpha: 1)
    }
    
}


//MARK:>>>> Change constraint multiplier

extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
    
    func changewidth(constant:CGFloat)  -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: Relation.greaterThanOrEqual,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}


//MARK:>>>>> UICOLOR

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexValue: Int) {
        self.init(
            red: (hexValue >> 16) & 0xFF,
            green: (hexValue >> 8) & 0xFF,
            blue: hexValue & 0xFF
        )
    }
}

//MARK:>>>>> UIVIEW

extension UIView{
    
    //to get the shadow on view and setting its opacity and radius as well
    func GetShadow(myview:UIView,opacity:Float,Shadowradius:CGFloat){
        
        myview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        myview.layer.shadowOffset = CGSize(width: 0, height: 1)
        myview.layer.shadowOpacity = opacity
        myview.layer.shadowRadius = Shadowradius
        
    }
    
    
    
//    //to get border of desired color
//    func GetBorder(myview:UIView){
//
//        myview.layer.borderWidth = 0.5
//        myview.layer.borderColor = Constants.constaTheme.cgColor
//    }
    
}


////MARK:>>>>> Navigation bar
//
//extension UINavigationController{
//
//    func navigationBarSetup(){
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
//        self.title = ""
//        let btn1 = UIButton(type: .custom)
//        btn1.setImage(UIImage(named: "back"), for: .normal)
//        btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
//        btn1.addTarget(self, action: #selector(tapSideMenu), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: btn1)
//        self.navigationItem.leftBarButtonItem = item1
//
//    }
//
//}


extension UILabel{
    
    //get number of label lines
    
    func CountLabel(label:UILabel) -> Int{
        let mytext = label.text! as NSString
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelsize = mytext.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font!], context: nil)
        //return Int(ceil(labelsize.height / label.font.lineHeight))
        return Int(ceil(CGFloat(labelsize.height) / label.font.lineHeight))
    }
    
}


//uiimage extension

extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        
        var resizingImage = self
        
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
}

