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

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var ref: DatabaseReference!
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    // Define identifier
    let notificationName = Notification.Name("LoggedIn")
    
    let baseURL = URL(string: "https://accounts.spotify.com/authorize")!

    
    func setup() {
        auth.clientID = "fe10c4ee20a14c74b6192b7973395153"
        auth.redirectURL = URL(string: "Project://returnAfterLogin")
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
            SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
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
    
    @objc func updateAfterFirstLogin () {
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            initializePlayer(authSession: session)
            
            // Request access token
            let clientURL = baseURL.appendingPathComponent("\(auth.clientID)")
            let typeURL = clientURL.appendingPathComponent("code")
            let requestURL = typeURL.appendingPathComponent("\(auth.redirectURL)")

            let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data,
                    let tokenItem = try? jsonDecoder.decode(TokenItem.self, from: data) {
                        TokenItem.shared = tokenItem
                } else {
//                    completion(nil)
                }
            }
        }
        let uid = Auth.auth().currentUser?.uid
        let addToken = ref.child("users").child(uid!).child("access_token")
        addToken.setValue(TokenItem.shared?.access_token)
    }
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
        
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    func fetchImage() {
        let imageURL = URL(string: "https://api.spotify.com/v1/me")
        var request = URLRequest(url: imageURL!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(TokenItem.shared?.access_token)", forHTTPHeaderField: "Autherization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let image = UIImage(data: data) {
                self.profilePicture.image = image
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("user").child(uid!).observe(.value) { (snapshot) in
            self.nameLabel = value?("username") as! UILabel // dunno whyyyyyyyyy help
        }
        setup()
        fetchImage()
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.updateAfterFirstLogin), name: notificationName, object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
