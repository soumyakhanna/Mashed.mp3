//
//  UserHomeViewController.swift
//  Displays the created visualization
//
//  Created by Macbook Air on 4/21/21.
//  Copyright © 2021 John Codeos. All rights reserved.
//

import UIKit
import WebKit

class UserHomeViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var UserNameL: UILabel!
    @IBOutlet var webView: WKWebView!
    var spotifyDisplayName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameL.text = spotifyDisplayName
        
        let viz = UIImage.gifImageWithName("viz1-2")
        let imageView = UIImageView(image: viz)
        imageView.frame = CGRect(x: 0.0, y: 100.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(imageView)
    }
}
