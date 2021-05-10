//
//  DetailsViewController.swift
//  Manages multiple API requests
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
    var idPlaylist = ""
    var idTracks = [String]()
    var jsonFeatures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spotifyIdLabel.text = spotifyId
        spotifyDisplayNameLabel.text = spotifyDisplayName
        spotifyEmailLabel.text = spotifyEmail
        
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
                            print("------Request 1: JSON---------")
                            print(json)
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
                                            }
                                            print("------R1: Playlist ID---------")
                                            print("Playlist ID: \(id)")
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
        dataTask.resume()
    }
    
    func getTracks(playlistID: String){
        
        print("Playlist ID after: \(idPlaylist)")
        guard let url2 = URL(string: "https://api.spotify.com/v1/playlists/\(idPlaylist)/tracks") else { print("url2"); return }
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
                    do {
                        // make sure this JSON is in the format we expect
                        if let json2 = try JSONSerialization.jsonObject(with: data2, options: []) as? [String: Any] {
                            print("------Request 2: JSON---------")
                            print(json2)
                            if let items2 = json2["items"] as? NSArray {
                                for tracks in items2{
                                    print("-----------R2  TRACKS------------")
                                    print(tracks)
                                    if let i2 = tracks as? [String:Any] {
                                            if let item = i2["track"] as? [String:Any] {
                                                let id = (item["id"] as! String)
                                                do {
                                                    self.idTracks.append(id)
                                                    self.getTracksInfo(trackID: id)
                                                }
                                                print("------R2: Track ID---------")
                                                print("Track ID: \(id)")
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
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            print("------Request 3: JSON---------")
                            print("------R3: Track Audio Features---------")
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
        if let newVC: UserHomeViewController = segue.destination as? UserHomeViewController {
            let passedPhrase = spotifyDisplayName
            newVC.spotifyDisplayName = passedPhrase
        }
        else {
            let newVC: VizCollectionViewController = (segue.destination as? VizCollectionViewController)!
        }
    }
}
