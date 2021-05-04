//
//  UserHomeViewController.swift
//  SpotifySignInExample
//
//  Created by Macbook Air on 4/21/21.
//  Copyright © 2021 John Codeos. All rights reserved.
//

import UIKit

class UserHomeViewController: UIViewController {

    @IBOutlet weak var UserNameL: UILabel!
    
    var spotifyDisplayName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    UserNameL.text = spotifyDisplayName
        // Do any additional setup after loading the view.
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
