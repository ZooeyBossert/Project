//
//  ConnectionsViewController.swift
//  Project
//
//  Created by Zooey Bossert on 20-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase

class ConnectionsViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var locationManager:CLLocationManager!
    
    var ref: DatabaseReference!
    var username: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsername()
        determineMyCurrentLocation()
    }
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Update Database
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.latitude
        let addLatChild = ref.child("users").child(uid!).child("latitude")
        addLatChild.setValue(self.latitude)
        let addLongChild = ref.child("users").child(uid!).child("longitude")
        addLongChild.setValue(self.longitude)
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.latitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map. make marker for friends en dat je kan klikken
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.latitude)
        marker.title = self.username
        marker.map = mapView
    }
    
    func getUsername() {
        print("update useername")
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.username = value?["username"] as? String ?? ""
        })
    }
    
//    // Create Markers
//    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: Float, longitude: Float) {
//        let marker = GMSMarker()
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        marker.title = titleMarker
//        marker.icon = iconMarker
//        marker.map = mapView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
