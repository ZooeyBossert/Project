//
//  SearchViewController.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import HTMLString

class SearchViewController: UIViewController {

    //MARK : - Variables
    @IBOutlet weak var qTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        submitSearch()
        performSegue(withIdentifier: "SearchSegue", sender: self)
    }
    
    var names = [String]()
    
    typealias JSONStandard = [String: AnyObject]
    
    // Get access token
    let token = TokenItem.shared?.access_token
    
    // base url moet nog aangepast en zorgen voor en search url
//    var baseURL: String = "https://api.spotify.com/v1/search"
    
    //MARK: - Functions
    // make this the submit button function?
    func submitSearch() {
        // create baseurl and add in other function the search request
        var first = qTextField.text
        var second = typeTextField.text

        var q = first?.lowercased()
        q?.addingASCIIEntities
        print("\n")
        print(q)
        let type = second?.lowercased()
        print("\n")
        print(type)
        
//        let search = "https://api.spotify.com/v1/search?q=\(q)&type=\(type)"
        let searchURL = URL(string: "https://api.spotify.com/v1/search?q=\(q)&type=\(type)")!
        
//        ???
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
//        components.queryItems = [URLQueryItem(name: "q=\(q)&type=\(type)", value: ]
//        let searchURL = components.url!
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        print("\n")
        print(request)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\n")
        print(request)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Autherization")
        print("\n")
        print(request)
        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            if let data = data,
//                if type == "album",
//                    let albumItem = try? jsonDecoder.decode(AlbumItem.self, from: data) {
//                    completion(albumItems.items)
//                }
//                if type == "artist",
//                    let artistItem = try? jsonDecoder.decode(ArtistItem.self, from: data) {
//                    completion(artistItems.items)
//                }
//                if type == "track",
//                    let trackItem = try? jsonDecoder.decode(TrackItem.self, from: data) {
//                    completion(trackItems.items)
//                }
//                if type == "playlist",
//                    let playlistItem = try? jsonDecoder.decode(PlaylistItem.self, from: data) {
//                    completion(playlistItems.items)
//                }else {
//                    completion(nil)
//                }
//        }
//        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let type = typeTextField.text?.lowercased()
        }
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
