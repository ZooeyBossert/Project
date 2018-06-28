//
//  SettingsTableViewController.swift
//  Project
//
//  Created by Zooey Bossert on 06-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseUI

class SettingsTableViewController: UITableViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    //MARK: - Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var ref: DatabaseReference!
    
    // Spotify login variables
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    var user = SPTUser()
    
    // Define identifier
    let notificationName = Notification.Name("LoggedIn")
    
    var code: String = ""
    var seen = false
    
    let baseURL = URL(string: "https://accounts.spotify.com/api/token")!
    
    // Setup for Spotify
    func setup() {
        auth.clientID = "fe10c4ee20a14c74b6192b7973395153"
        auth.redirectURL = URL(string: "Project://returnAfterLogin")
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
            SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    // Add access token to database
    func addToken(){
        let token = AppDelegate.accessToken
        let uid = Auth.auth().currentUser?.uid
        let newToken = self.ref.child("users").child(uid!).child("access_token")
        newToken.setValue(token)
    }
    
    // Login to Spotify
    @IBAction func LoginButtonPressed(_ sender: Any) {
        if seen == false {
            if UIApplication.shared.openURL(loginUrl!) {
                seen = true
                if auth.canHandle(auth.redirectURL) {
                }
            }
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.updateAfterFirstLogin), name: notificationName, object: nil)
        }
    }
    
    // Keep track if user is logged in
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if seen == true {
            NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.updateAfterFirstLogin), name: notificationName, object: nil)
            NotificationCenter.default.post(name: notificationName, object: nil)
            
        }
    }
    
    // Update username label
    func updateUsername() {
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            self.nameLabel.text = username
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUsername()
        self.tableView.rowHeight = 44;
        setup()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func updateAfterFirstLogin () {
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            initializePlayer(authSession: session)
            addToken()
        }
    }
    
    func initializePlayer(authSession:SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self as! SPTAudioStreamingPlaybackDelegate
            self.player!.delegate = self as! SPTAudioStreamingDelegate
            try! player!.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source





    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
