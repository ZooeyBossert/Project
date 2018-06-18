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

class ViewController: UIViewController {
    
//    // Doet niet ref naar database
//    var ref: DatabaseReference!
//    ref = Database.database().reference()
    
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
            performSegue(withIdentifier: "LoggedInSegue", sender: self)
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary ???!!!
        performSegue(withIdentifier: "LoggedInSegue", sender: self)
        print("authUI")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

