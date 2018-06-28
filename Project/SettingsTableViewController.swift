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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    
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

//    // Log out of app
//    @IBAction func logOutPressed(_ sender: Any) {
//        FUIAuth.defaultAuthUI()?.signOut()
//    }
    
    func setup() {
        auth.clientID = "fe10c4ee20a14c74b6192b7973395153"
        auth.redirectURL = URL(string: "Project://returnAfterLogin")
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
            SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }

//    @IBAction func logOut(_ sender: UIButton) {
//        FUIAuth.defaultAuthUI()?.signOut()
//    }
    
    func addToken(){
        let token = AppDelegate.accessToken
        print(token)
        let uid = Auth.auth().currentUser?.uid
        let newToken = self.ref.child("users").child(uid!).child("access_token")
        newToken.setValue(token)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        if seen == false {
            if UIApplication.shared.openURL(loginUrl!) {
                seen = true
                if auth.canHandle(auth.redirectURL) {
                    print(auth.redirectURL)
                    // code van ontvangen uri opslaan en als state error geven melding
                }
            }
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.updateAfterFirstLogin), name: notificationName, object: nil)
        }
    }
    
//    func fetchImage() {
//        print("start fetch")
//        let imageURL = URL(string: "https://api.spotify.com/v1/me")!
//        var request = URLRequest(url: imageURL)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(AppDelegate.accessToken))", forHTTPHeaderField: "Autherization")
//        print("request: \(request)")
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            if let data = data,
//                let userProfile = try? jsonDecoder.decode(UserProfile.self, from: data) {
//                UserProfile.shared = userProfile
//                print(userProfile)
//                let image = userProfile.images
//                print(image)
////             self.profilePicture.image = image as
//            }
//        }
//        task.resume()
//    }
    
    func fetchImage(authSession:SPTSession){
        if user == SPTUser(){
            print(user)
            let images = user.images
            print(images)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if seen == true {
            NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.updateAfterFirstLogin), name: notificationName, object: nil)
            NotificationCenter.default.post(name: notificationName, object: nil)
            
        }
    }
    
    func updateUsername() {
        print("update useername")
        ref = Database.database().reference()
        print(ref)
        let uid = Auth.auth().currentUser?.uid
        print(uid)
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            self.nameLabel.text = username
            print(username)
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
            print("resuest token")
            addToken()
            print("fetch image")
            fetchImage(authSession: session)
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
