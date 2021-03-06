//
//  AppDelegate.swift
//  Project
//
//  Created by Zooey Bossert on 04-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var auth = SPTAuth()
    var session: SPTSession!
    
    var ref: DatabaseReference!
    
    static var accessToken: String = ""
    
    override init() {
        super.init()
        FirebaseApp.configure()
        
        // not really needed unless you really need it FIRDatabase.database().persistenceEnabled = true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // App login on Firebase
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self as? FUIAuthDelegate
        
        //Google Maps API
        GMSServices.provideAPIKey("AIzaSyC2EWKAASQ3Eoj8VLCx3vH9PfNjlAz_jrM")
        
        // Spotify login
        auth.redirectURL     = URL(string: "Project://returnAfterLogin")
        auth.sessionUserDefaultsKey = "current session"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
                                SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // check if app can handle redirect URL
        if auth.canHandle(auth.redirectURL) {
            // handle callback in closure
            auth.handleAuthCallback(withTriggeredAuthURL: url , callback: { (error, session) in
                // handle error
                if error != nil {
                    print("error!")
                }
                // Add session to User Defaults
                let userDefaults = UserDefaults.standard
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
                userDefaults.set(sessionData, forKey: "SpotifySession")
                userDefaults.synchronize()
                // Tell notification center login is successful
                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
            })
            return true
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let stringURL = "\(url)"
        var queryPartlySep = stringURL.components(separatedBy: "=")
        for char in queryPartlySep[1] {
            if char != "&" {
                AppDelegate.accessToken.append(char)
            } else {
                break
            }
        }
        return true
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

