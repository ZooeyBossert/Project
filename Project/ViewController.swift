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
    
    let authViewController = FUIAuth.defaultAuthUI()?.authViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(authViewController!, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary ???!!!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

