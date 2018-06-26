//
//  CLLocationManager.swift
//  Project
//
//  Created by Zooey Bossert on 21-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation
import MapKit
import Firebase
import FirebaseDatabase
import FirebaseUI

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(_ location : CLLocation)
}

let kLocationDidChangeNotification = "LocationDidChangeNotification"

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let SharedManager = UserLocationManager()
    
    fileprivate var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var delegate : LocationUpdateProtocol!
    
    fileprivate override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager,didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        currentLocation = newLocation
        let userInfo : NSDictionary = ["location" : currentLocation!]
        
        
        DispatchQueue.main.async() { () -> Void in
            self.delegate.locationDidUpdateToLocation(self.currentLocation!)
            NotificationCenter.default.post(name: Notification.Name(kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
        }
        
        // Update Database
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let latitude = self.currentLocation?.coordinate.latitude
        let longitude = self.currentLocation?.coordinate.longitude
        let addUID = ref.child("users").child(uid!)
        let addLatChild = ref.child("users").child(uid!).child("latitude")
        addLatChild.setValue(latitude)
        let addLongChild = ref.child("users").child(uid!).child("longitude")
        addLongChild.setValue(longitude)
    }
    
}
