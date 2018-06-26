//
//  PlayerViewController.swift
//  Project
//
//  Created by Zooey Bossert on 21-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // Variables to play music
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    
    // MARK: - View Variables
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
    

    //TODO: - make function foor stream and link playing var with button tapped link
    //    function om audio te streamen
        func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
            // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
            self.player?.playSpotifyURI("spotify:track:\(TrackItem.shared?.id)", startingWith: 0, startingWithPosition: 0, callback: { (error) in
                if (error != nil) {
                    print("playing!")
                }
            })
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
