//
//  PlayerViewController.swift
//  Project
//
//  Created by Zooey Bossert on 21-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // MARK: - Variables
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    
    // variablen track en playlist maken en variablen van currentsong
    var track: Int = 0
    var playlist = [TrackItem]()
    var currentSong: Int = 0
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    
    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                playPauseButton.setImage(UIImage(named:
                "pause")!, for: .normal)
            } else {
                playPauseButton.setImage(UIImage(named:
                "play-1")!, for: .normal)
            }
        }
    }
    
    // MARK: - Functions
    @IBAction func playButtonPressed(_ sender: Any) {
        if isPlaying == false{
            let musicItem = playlist[track]
            self.player?.playSpotifyURI("spotify:track:\(musicItem.id)", startingWith: 0, startingWithPosition: 0, callback: { (error) in
                if (error != nil) {
                    print("playing!")
                    self.currentSong = self.track
                }
            })
            isPlaying = true
//            // als huidige nummer is afgelopen speel volgende af
//            if self.player?..... {
//                self.currentSong += 1
//                let musicItem = playlist[currentSong]
//                self.player?.playSpotifyURI("spotify:track:\(musicItem.id)", startingWith: 0, startingWithPosition: 0, callback: { (error) in
//                    if (error != nil) {
//                        print("play next song")
//                    }
//                })
//            }
        } else {
            self.player?.setIsPlaying(false, callback: { (Error) in
                print("pause")
            })
        }
    }
    
    @IBAction func reverseButtonPressed(_ sender: UIButton) {
        self.currentSong -= 1
        let musicItem = playlist[currentSong]
        self.player?.playSpotifyURI("spotify:track:\(musicItem.id)", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("play last song")
            }
        })
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        self.currentSong += 1
        let musicItem = playlist[currentSong]
        self.player?.playSpotifyURI("spotify:track:\(musicItem.id)", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("play next song")
            }
        })
    }
    
    // Initialize Spotify player
    func initializePlayer(authSession:SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self as! SPTAudioStreamingPlaybackDelegate
            self.player!.delegate = self as! SPTAudioStreamingDelegate
            try! player!.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }

    // create buttons
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePlayer(authSession: session)
        
        reverseButton.layer.cornerRadius = 35.0
        reverseButton.clipsToBounds = true
        reverseButton.alpha = 0.0
        
        playPauseButton.layer.cornerRadius = 35.0
        playPauseButton.clipsToBounds = true
        playPauseButton.alpha = 0
        
        forwardButton.layer.cornerRadius = 35.0
        forwardButton.clipsToBounds = true
        forwardButton.alpha = 0.0
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
