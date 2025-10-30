//
//  ViewController.swift
//  MiniMusicPlayer
//
//  Created by Assylzhan on 30.10.2025.
//

import UIKit
import AVFoundation

struct TrackItem{
    let title: String
    let image: UIImage
    let soundFileName: String
}

class ViewController: UIViewController {
    
    let tracks:[TrackItem] = [
        TrackItem(title: "Borderline", image: .borderline, soundFileName: "borderline"),
        TrackItem(title: "Dracula", image: .dracula, soundFileName: "dracula"),
        TrackItem(title: "End Of Summer", image: .endofsummer, soundFileName: "endofsummer"),
        TrackItem(title: "Let It Happen", image: .letithappen, soundFileName: "letithappen"),
        TrackItem(title: "Loser", image: .loser, soundFileName: "loser"),
        TrackItem(title: "Neverender", image: .neverender, soundFileName: "neverender"),
        TrackItem(title: "New Person, Same Old Mistakes", image: .newperson, soundFileName: "newperson"),
        TrackItem(title: "The Less I Know The Better", image: .theless, soundFileName: "theless")
    ]
    
    var player = AVAudioPlayer()
    var isPlaying: Bool = false
    var currentTrackIndex: Int = 3
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func playSound(){
        let track = tracks[currentTrackIndex]
        
        guard let url = Bundle.main.url(forResource: track.soundFileName, withExtension: "mp3") else {return}
        
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
        isPlaying = true
        
        titleLabel.text = track.title
        imageView.image = track.image
    }
    
    @IBAction func previousButtonTapper(_ sender: Any) {
        if currentTrackIndex == 0{
            currentTrackIndex = 7
        }
        else {
            currentTrackIndex -= 1
        }
        playSound()
    }
    
    @IBAction func nextButtonTapper(_ sender: Any) {
        if currentTrackIndex == 7{
            currentTrackIndex = 0
        }
        else{
            currentTrackIndex += 1
        }
        playSound()
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if isPlaying{
            player.pause()
            isPlaying = false
//            playButton.configuration?.title = "Play"
        }
        else{
//            playButton.configuration?.title = "Pause"
            if player.url == nil{
                playSound()
            }
            else{
                player.play()
                isPlaying = true
            }
        }
    }

}
