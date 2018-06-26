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
    
    // Create empty string
    var result = [TrackItem]()
    var finalType = ""
    
    typealias JSONStandard = [String: AnyObject]
    
    // Get access token
    let token = TokenItem.shared?.access_token
    
    // Create baseURL for the search
    var baseURL = URL(string: "https://api.spotify.com/v1/search")
    
    //MARK: - Functions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        submitSearch { (results)  in
            self.result = results! 
            self.performSegue(withIdentifier: "SearchSegue", sender: self)
        }
    }

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
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Autherization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                    if let trackItem = try? jsonDecoder.decode(TrackItems.self, from: data) {
                    completion(trackItem.items)
                }
            }
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let resultTableViewController = segue.destination as! ResultTableViewController
            resultTableViewController.results = self.result
            
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
