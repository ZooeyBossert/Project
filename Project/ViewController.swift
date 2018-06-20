//
//  ViewController.swift
//  Project
//
//  Created by Zooey Bossert on 04-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Ref naar database
    var ref: DatabaseReference!
    
    let authViewController = FUIAuth.defaultAuthUI()?.authViewController()
    var seen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if seen == false {
            present(authViewController!, animated: true, completion: nil)
            seen = true
        } else {
            print("vwa")
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
            print("signed in")
        } else {
            print("else")
            //iets doen
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary ???!!!
        print("auth")
        userSave()
        performSegue(withIdentifier: "LoggedInSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

