//
//  ViewController.swift
//  Project
//
//  Created by Zooey Bossert on 04-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, LocationUpdateProtocol {
    
    // Ref to database
    var ref: DatabaseReference!
    
    // Create current location var
    var currentLocation : CLLocation!
    
    // Reference to Firebase auth view controller
    let authViewController = FUIAuth.defaultAuthUI()?.authViewController()
    var seen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if seen == false {
            present(authViewController!, animated: true, completion: nil)
            seen = true
        } else {
            locationNotification()
            userSave()
            performSegue(withIdentifier: "LoggedInSegue", sender: self)
        }
    }
    
    func userSave() {
        if Auth.auth().currentUser != nil {
            ref = Database.database().reference()
            let uid = Auth.auth().currentUser?.uid
            let username = Auth.auth().currentUser?.displayName
            let addUID = ref.child("users").child(uid!)
            let addNameChild = ref.child("users").child(uid!).child("username")
            addNameChild.setValue(username!)
        } else {
            //iets doen
        }
    }
    
    func locationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.locationUpdateNotification(_:)), name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: nil)

        let LocationMgr = UserLocationManager.SharedManager
        LocationMgr.delegate = self as! LocationUpdateProtocol
    }

    @objc func locationUpdateNotification(_ notification: Notification) {
        let userinfo = notification.userInfo
        self.currentLocation = userinfo!["location"] as! CLLocation
        print("Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Longitude : \(self.currentLocation.coordinate.longitude)")
    }

    // MARK: - LocationUpdateProtocol

    func locationDidUpdateToLocation(_ location: CLLocation) {
        currentLocation = location
        print("Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Longitude : \(self.currentLocation.coordinate.longitude)")
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary ???!!!
        locationNotification()
        userSave()
        performSegue(withIdentifier: "LoggedInSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

