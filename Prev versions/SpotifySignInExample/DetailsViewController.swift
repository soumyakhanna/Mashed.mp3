//
//  DetailsViewController.swift
//  SpotifySignInExample
//
//  Created by John Codeos on 11/7/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var spotifyIdLabel: UILabel!
    @IBOutlet weak var spotifyDisplayNameLabel: UILabel!
    @IBOutlet weak var spotifyEmailLabel: UILabel!
    @IBOutlet weak var spotifyAvatarUrlLabel: UILabel!
    @IBOutlet weak var spotifyAccessTokenLabel: UILabel!
    
    
    var spotifyId = ""
    var spotifyDisplayName = ""
    var spotifyEmail = ""
    var spotifyAvatarURL = ""
    var spotifyAccessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spotifyIdLabel.text = spotifyId
        spotifyDisplayNameLabel.text = spotifyDisplayName
        spotifyEmailLabel.text = spotifyEmail
        //spotifyAvatarUrlLabel.text = spotifyAvatarURL
        spotifyAccessTokenLabel.text = spotifyAccessToken
        
        //URL (using my username,(nevemind using me insted of users/me) will need to change later?)
        //endpoint
        let url = URL(string:"https://api.spotify.com/v1/me/playlists")
        
        guard url != nil else{
            print("Error creating url object")
            return
        }
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        //Specify the header **?
        let header = [spotifyAccessToken:""]
        
        request.allHTTPHeaderFields = header
        
        //Specify the body
        let jsonObject = ["":""]
        
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
            request.httpBody = requestBody
        }
        catch{
            print("Error creating the data objects")
        }
        
        //Set the request type
        request.httpMethod = "GET"
        
        //get the URLSession
        
        let session = URLSession.shared
        
        //create the data task
        
        //let dataTask = session.dataTask(with: request){ data, response, error) in
            //check for error
            //if error == nil && data != nil {
                //no error, parse out data
            //}
        }
        
        //make api call (fire off the data task)

    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: UserHomeViewController = segue.destination as! UserHomeViewController
        let passedPhrase = spotifyDisplayName
        newVC.recievedSpotifyDisplayName = passedPhrase
    }
}

