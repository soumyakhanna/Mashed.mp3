//import UIKit
//import WebKit
//import AVFoundation
//import SafariServices
//
//class PlayVC: UIViewController, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
//func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController) {
//        let playListRequest = try! SPTPlaylistList.createRequestForGettingPlaylists(forUser: session.canonicalUsername, withAccessToken: session.accessToken)
//        Alamofire.request(playListRequest)
//            .response { response in
//                let list = try! SPTPlaylistList(from: response.data, with: response.response)
//
//                for playList in list.items  {
//                    if let playlist = playList as? SPTPartialPlaylist {
//                        print( playlist.name! ) // playlist name
//                        print( playlist.uri!)    // playlist uri
//                      // self.tableView.reloadData()// if u want to display playlist name and other stuffs like so..
//                        SPTAudioStreamingController.sharedInstance().playSpotifyURI("\(playlist.uri!)", startingWith: 0, startingWithPosition: 10) { error in
//                            if error != nil {
//                                print("*** failed to play: \(error)")
//                                return
//                            }
//                        }
//                        }}}
//
//    }
//}
