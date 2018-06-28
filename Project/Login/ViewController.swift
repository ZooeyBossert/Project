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

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    // Ref to database
    var ref: DatabaseReference!
    
    // Create current location var
    var locationManager:CLLocationManager!

    // Reference to Firebase auth view controller
    let authViewController = FUIAuth.defaultAuthUI()?.authViewController()
    var seen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Make sure view appears otherwise perform segue
    override func viewDidAppear(_ animated: Bool) {
        if seen == false {
            present(authViewController!, animated: true, completion: nil)
            seen = true
        } else {
            userSave()
            performSegue(withIdentifier: "LoggedInSegue", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    // Get current location with location manager
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    // Location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Update Database
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.latitude
        let addLatChild = ref.child("users").child(uid!).child("latitude")
        addLatChild.setValue(latitude)
        let addLongChild = ref.child("users").child(uid!).child("longitude")
        addLongChild.setValue(longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    // Save user in database
    func userSave() {
        if Auth.auth().currentUser != nil {
            ref = Database.database().reference()
            let uid = Auth.auth().currentUser?.uid
            let username = Auth.auth().currentUser?.displayName
            let addNameChild = ref.child("users").child(uid!).child("username")
            addNameChild.setValue(username!)
        } 
    }
    


    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        userSave()
        performSegue(withIdentifier: "LoggedInSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

