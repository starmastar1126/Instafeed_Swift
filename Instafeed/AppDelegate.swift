//
//  AppDelegate.swift
//  Instafeed
//
//  Created by gulam ali on 08/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FacebookCore
import FacebookLogin
import FacebookShare
import FBSDKCoreKit
import GoogleSignIn
import CoreLocation
import GooglePlaces
import GoogleMaps

var UserCurrentLocation = CLLocationCoordinate2D()
var RecordedAudio : URL?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldPlayInputClicks = false

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)  //for fb
 
        GIDSignIn.sharedInstance().clientID = constnt.Google_key
        GIDSignIn.sharedInstance().delegate = self
        
        GMSServices.provideAPIKey(constnt.googleMapsKey)
        GMSPlacesClient.provideAPIKey(constnt.googleMapsKey)    

        
        if UserDefaults.standard.isLoggedIn() == true{
            let story = UIStoryboard.init(name: "categoryStoryboard", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "Mainpagevc") as! Mainpagevc
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }else{
          // rootlogin()
        }
        
        return true

    }
    
    func rootlogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "startnav")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let appId: String = constnt.fbApp_id
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }else if url.scheme != nil{
            
            let googleSignIn = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])

            return googleSignIn
            
        }

        
        return false
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate : GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
           // let userId = user.userID                  // For client-side use only!
           // let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
           // let familyName = user.profile.familyName
            let email = user.profile.email
            print(fullName!,givenName!,email!)
        }
    }
    
    
    
    
    
}
