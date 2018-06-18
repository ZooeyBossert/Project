////
////  SearchViewController.swift
////  Project
////
////  Created by Zooey Bossert on 18-06-18.
////  Copyright © 2018 Zooey Bossert. All rights reserved.
////
//
//import UIKit
//
//class SearchViewController: UIViewController {
//
//    //MARK : - Variables
//    @IBOutlet weak var qTextField: UITextField!
//    @IBOutlet weak var typeTextField: UITextField!
//    @IBOutlet weak var searchButton: UIButton!
//
//    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "SearchSegue", sender: self)
//    }
//    
//    var names = [String]()
//    
//    typealias JSONStandard = [String: AnyObject]
//    
//    // Get access token
//    let token = TokenItem.shared?.access_token
//    
//    // base url moet nog aangepast en zorgen voor en search url
//    let baseURL = URL(string: "https://api.spotify.com/v1/search?q=post%20malone&type=artist")!
//    // q en type opvragen van persoon en toevoegen aan searchurl+...
//    
//    //MARK: - Functions
//    
//    // make this the submit button function?
//    func submitOrder(musicIds: [Int], completion: @escaping (Int?) -> Void) {
//        // create baseurl and add in other function the search request
//        //        let searchURL = baseURL.appendingPathComponent("order")
//        var request = URLRequest(url: baseURL)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Autherization")
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            if let type = "album",
//                let albumItem = try? jsonDecoder.decode(AlbumItem.self, from: data) {
//                AlbumItem.shared = albumItem
//            }
//            if type = "artist",
//                let artistItem = try? jsonDecoder.decode(ArtistItem.self, from: data) {
//                ArtistItem.shared = artistItem
//            }
//            if type = "track",
//                let trackItem = try? jsonDecoder.decode(TrackItem.self, from: data) {
//                TrackItem.shared = trackItem
//            }
//            if type = "playlist",
//                let playlistItem = try? jsonDecoder.decode(PlaylistItem.self, from: data) {
//                PlaylistItem.shared = playlistItem
//            }else {
//                //                    completion(nil)
//            }
//        }
//        task.resume()
//    }
//    
//    
//    override func prepare(for segue: UIStoryboardSegue,
//                          sender: Any?) {
//        if segue.identifier == "SearchSegue" {
//            // geef gevonden struct mee aan result om te weergeven
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let q = qTextField.text
//        let type = typeTextField.text
//        
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
