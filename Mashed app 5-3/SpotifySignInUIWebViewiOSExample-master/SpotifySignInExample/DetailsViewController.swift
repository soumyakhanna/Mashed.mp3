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
//    @IBOutlet weak var spotifyAccessTokenLabel: UILabel!
    @IBOutlet weak var spotifyPlaylistID: UILabel!
    
    var spotifyId = ""
    var spotifyDisplayName = ""
    var spotifyEmail = ""
    var spotifyAvatarURL = ""
    var spotifyAccessToken = ""
    var idPlaylist = ""
    var idTracks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spotifyIdLabel.text = spotifyId
        spotifyDisplayNameLabel.text = spotifyDisplayName
        spotifyEmailLabel.text = spotifyEmail
        spotifyAccessTokenLabel.text = spotifyAccessToken
        spotifyPlaylistID.text = idPlaylist
        
        //URL (using my username,(nevemind using me insted of users/me) will need to change later?)
        //endpoint
        
        //URL request for list of user's Playlists
        let authToken = spotifyAccessToken
        guard let url = URL(string: "https://api.spotify.com/v1/me/playlists") else { print("url"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(String(authToken))", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared

        let dataTask = session.dataTask(with:request) { data, response, error in

            if let response = response as? HTTPURLResponse {
                 if let data = data {
                // try to print list of playlists for user
                    let dataReadable = String(data:data, encoding: .utf8)
//                    print("\(dataReadable!)")
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
//                            print(json)
                            if let items = json["items"] as? NSArray {
                                for playlist in items{
//                                print(playlist)
                                    if let item = playlist as? [String: Any] {
//                                        print(item["name"])
                                        if item["name"] as! String == "Mashed.mp3"{
                                            let id = (item["id"] as! String)
                                            do {
                                                self.idPlaylist = id
                                                self.getTracks(playlistID: self.idPlaylist)
//                                                sleep(5000)
                                            }
                                            print("Playlist ID: \(self.idPlaylist)")
                                        }
                                    }
                                }
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            }
            else {
                // display error message
                print("ERROR")
            }
        }
//        sleep(30)
//        print("Playlist ID before: \(idPlaylist)")
        dataTask.resume()
        //make api call (fire off the data task)
        
        //GET request for a single playlist's items
//        print(spotifyId)
//        sleep(1000)
        
    }
    
    func getTracks(playlistID: String){
        
        print("Playlist ID after: \(idPlaylist)")
        guard let url2 = URL(string: "https://api.spotify.com/v1/playlists/\(idPlaylist)/tracks") else { print("url2"); return }
//        print(url2)
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "GET"
        request2.addValue("Bearer \(String(spotifyAccessToken))", forHTTPHeaderField: "Authorization")
        request2.addValue("US", forHTTPHeaderField: "market")
        
        let session2 = URLSession.shared
        let dataTask2 = session2.dataTask(with:request2) { data, response, error in

            if let response2 = response as? HTTPURLResponse {
                 if let data2 = data {
                // try to print list of playlists for user
                    let dataReadable2 = String(data:data2, encoding: .utf8)
//                    print("\(dataReadable!)")
                    do {
                        // make sure this JSON is in the format we expect
                        if let json2 = try JSONSerialization.jsonObject(with: data2, options: []) as? [String: Any] {
                            print("-----JSON--------")
//                            print(json2)
                            if let items2 = json2["items"] as? [String:NSArray] {
//                                self.getTracksInfo(trackID: "04Mjx3X5frf0toksOJVcW9")
                                print("-------ITEMS2-----------")
//                                print(items2)
//                                if items2 as! String == "track"{
//                                if let tracks = items2["track"] as? NSArray {
                                for tracks in items2{
                                    print("-----------TRACKS------------")
//                                    print(tracks)
                                    if let i2 = tracks as? NSArray {
                                        print("----I2------")
//                                        print(i2)
                                        for track in i2{
                                            print("--------TRACK------------")
                                            print(track)
                                            if let item = track as? [String:Any] {
                                                let id = (item["id"] as! String)
                                                do {
//                                                    self.idTrack = id
//                                                    self.getTracks(playlistID: self.idPlaylist)
    //                                                sleep(5000)
                                                }
                                                print("Track ID: \(id)")
                                   }
                                }
                            }
                        }
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            }
            else {
                // display error message
                print("ERROR")
            }
        }
        dataTask2.resume()
    }
    
    func getTracksInfo(trackID: String){
        
        guard let url = URL(string: "https://api.spotify.com/v1/audio-features/\(trackID)") else { print("url"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(String(spotifyAccessToken))", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared

        let dataTask = session.dataTask(with:request) { data, response, error in

            if let response = response as? HTTPURLResponse {
                 if let data = data {
                // try to print list of playlists for user
                    let dataReadable = String(data:data, encoding: .utf8)
//                    print("\(dataReadable!)")
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            print(json)
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            }
            else {
                // display error message
                print("ERROR")
            }
        }
        dataTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let newVC: UserHomeViewController = segue.destination as! UserHomeViewController
        let passedPhrase = spotifyDisplayName
       newVC.spotifyDisplayName = passedPhrase
        //let DestView = segue.destination as! DetailsViewController
        //DestView.spotifyDisplayName = self.spotifyDisplayName
    }
}

//        guard let url = URL(string: "https://api.spotify.com/v1/me/playlists") else { return default value }
//        //URL Request
//        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
//        //Specify the header **?
//        let header = [spotifyAccessToken:""]
//
//        request.allHTTPHeaderFields = header
        
        //Specify the body
//        let jsonObject = ["":""]
//
//        do{
//            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
//            request.httpBody = requestBody
//        }
//        catch{
//            print("Error creating the data objects")
//        }
//
//        //Set the request type
//        request.httpMethod = "GET"
//
        //get the URLSession
//        let session = URLSession.shared
//        let url = URL(string:"https://api.spotify.com/v1/me/playlists")
//
//        guard url != nil else{
//            print("Error creating url object")
//            return
//        }
//@IBAction func buttonAction(sender: AnyObject) {
        
    
   // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

   // let UserHomeViewController = storyBoard.instantiateViewController(withIdentifier: "UserHomeViewController") as! UserHomeViewController
    //self.present(UserHomeViewController, animated:true, completion:nil)
    //}
