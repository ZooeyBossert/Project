//
//  ItemViewController.swift
//  Project
//
//  Created by Zooey Bossert on 19-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    // MARK: - View Variables
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
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
