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
    
    var ref: DatabaseReference!
    
    // MARK: - View Variables
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
//    var track = TrackItem()
    
    @IBAction func addButtonPressed(_ sender: Any) {
//        let ref = Database.database().reference()
//        let uid = Auth.auth().currentUser?.uid
//        let addLatChild = ref.child("playlist").child(uid!).child(track.name)
//        addLatChild.setValue(track.id)
    }
    
    @IBAction func playPreview(_ sender: UIButton) {
//        let preview = track.preview_uri
//        self.player?.playSpotifyURI(preview, startingWith: 0, startingWithPosition: 0, callback: { (error) in
//            if (error != nil) {
//                print("playing!")
//            })
    }
    
    
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
