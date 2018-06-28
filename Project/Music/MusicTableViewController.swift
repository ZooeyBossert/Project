//
//  MusicTableViewController.swift
//  Project
//
//  Created by Zooey Bossert on 06-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class MusicTableViewController: UITableViewController {
    
    // MARK: - Variables
    var ref: DatabaseReference!
    
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    
    var playlist = [TrackItem]()
    var track: Int = 0
    var trackItem: TrackItem!
    var artists: [String] = []
    
    // MARK: - Functions
    
    // Fetch music from databse
    func fetchMusic() {
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let playlist = ref.child("playlist").child(uid!)
        playlist.observeSingleEvent(of: .value, with: { (snapshot) in
//                 loop maken om elke id langs te gaan
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                let value = rest.value as! NSDictionary
                let name = value["name"] as! String
                self.trackItem.name = name
                let id = value["id"] as! String
                self.trackItem.id = id
                let artist = value["artists"] as! [String]
                self.artists = artist
                let uri = value["uri"] as! String
                self.trackItem.uri = uri
                
                self.playlist.append(self.trackItem)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayMusicSegue" {
            let playerViewController = segue.destination as! PlayerViewController
            let index = tableView.indexPathForSelectedRow!.row
            playerViewController.track = index
            playerViewController.playlist = self.playlist
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMusic()
        self.tableView.rowHeight = 44;
        

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlist.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Retrieve name from result item
        let track = playlist[indexPath.row]
        cell.textLabel?.text = track.name
        return cell
    }

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
