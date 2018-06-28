//
//  SearchViewController.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import HTMLString
import Alamofire

class SearchViewController: UIViewController {

    //MARK : - Variables
    @IBOutlet weak var qTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // Create empty string
    var results = [TrackItem]()
    var ref: DatabaseReference!
    
    var auth = SPTAuth.defaultInstance()!
    var user: SPTUser!
    var search: SPTSearch!
    var session: SPTSession!
    var loginUrl: URL?
    
    typealias JSONStandard = [String: AnyObject]
    
    var token: String = ""
    
    // Get access token
    func getToken(){
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let accessToken = value?["access_token"] as? String ?? ""
            self.token = accessToken
        })
    }
    
    // Create baseURL for the search
    var baseURL = URL(string: "https://api.spotify.com/v1/search")
    
    //MARK: - Functions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        submitSearch { (results)  in
            self.results = results!
            print(self.results)
            self.performSegue(withIdentifier: "SearchSegue", sender: self)
        }
    }
    
//    func searchTrack() {
//        search(URLRequest()).create
//    }
    
    func submitSearch(completion: @escaping ([TrackItem]?) -> Void) {

        // create baseurl and add in other function the search request
        let first = qTextField.text

        // TODO: check first and second
        let q = first!.lowercased().addingASCIIEntities
        let type = "track"

        var components = URLComponents(url: baseURL!, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "q", value: q), URLQueryItem(name: "type", value: type)]
        let searchURL = components.url!

        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.token))", forHTTPHeaderField: "Authorization")
        print(request.allHTTPHeaderFields)
        print(request.debugDescription)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let data = data
            
            let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            let trackItem =
//            let data = datastring.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
//            let jsonDecoder = JSONDecoder()
//            if let data = data,
//                let trackItem = try? jsonDecoder.decode(TrackItems.self, from: data) {
//                print(trackItem.items)
                completion(data)
//            }
        }
        task.resume()
    }
    
        func setup() {
            auth.clientID = "fe10c4ee20a14c74b6192b7973395153"
            auth.redirectURL = URL(string: "Project://returnAfterLogin")
            auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope,
                                    SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
            loginUrl = auth.spotifyWebAuthenticationURL()
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let resultTableViewController = segue.destination as! ResultTableViewController
            resultTableViewController.results = self.results
            
        }
    }
    
    //            if let data = data{
    ////                let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
    //                let data : NSData = data.data(using: String.Encoding.utf8.rawValue)! as NSData
    //                let trackItems = try? jsonDecoder.decode(TrackItems.self, from: data as Data)
    //                print(trackItems!)
    //                completion(trackItems?.items)
    //            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
