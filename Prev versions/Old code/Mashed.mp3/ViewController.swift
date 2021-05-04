//
//  ViewController.swift
//  Mashed.mp3
//
//  Created by Macbook Air on 4/12/21.
//  Copyright © 2021 Macbook Air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let SpotifyClientID = "3f13d343248c43359538111754b4f6f0"
    let SpotifyRedirectURL = URL(string: "mashed-mp3-app-login://returnAfterLogin")!
    
    lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let parameters = appRemote.authorizationParameters(from: url);
        
        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
        }
        return true
    }


}

