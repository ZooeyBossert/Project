//
//  ItemViewController.swift
//  Project
//
//  Created by Zooey Bossert on 19-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseDatabase

class ItemViewController: UIViewController {
    
    //MARK: - Variables
    var ref: DatabaseReference!
    
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    
    // View variables
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var track: TrackItem!
    var artists: String = ""
    var artistArray: [String] = []
    var image: ImageObject!
    
    //MARK: - Functions
    
    // Add track to database
    @IBAction func addButtonPressed(_ sender: Any) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let nameChild = ref.child("playlist").child(uid!).child("\(track.name)")
        let addChild1 = nameChild.child("name")
        addChild1.setValue(track.name)
        let addChild2 = nameChild.child("id")
        addChild2.setValue(track.id)
        let addChild3 = nameChild.child("artists")
        addChild3.setValue(artistArray)
        let addChild4 = nameChild.child("uri")
        addChild4.setValue(track.uri)
        let addChild5 = nameChild.child("image_url")
        addChild5.setValue(track.album.images[0].url)
    }
    
    // Play preview of the song
    @IBAction func playPreview(_ sender: UIButton) {
        let preview = "track.preview_url"
        self.player?.playSpotifyURI(preview, startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    // Setup for Spotify player
    func setup() {
        auth.clientID = "fe10c4ee20a14c74b6192b7973395153"
        auth.redirectURL = URL(string: "Project://returnAfterLogin")
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
                                SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show only preview butten when a preview is available
        if track.preview_url != nil{
            previewButton.setTitle("Preview", for: UIControlState.application)
        }
        titelLabel.text = track.name
        for artist in track.artists {
            self.artists.append(artist.name)
            self.artistArray.append(artist.name)
        }
        artistLabel.text = self.artists
        setup()

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
