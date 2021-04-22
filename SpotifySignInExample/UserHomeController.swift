//
//  DetailsViewController.swift
//  SpotifySignInExample
//
//  Created by John Codeos on 11/7/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class UserHomeController: UIViewController {
     @IBOutlet weak var spotifyDisplayNameLabel: UILabel!
     
     var spotifyDisplayName = ""
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         spotifyDisplayNameLabel.text = spotifyDisplayName
     }
}
