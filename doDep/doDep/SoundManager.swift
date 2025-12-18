//
//  SoundManager.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    func playWinSound() {
//        AudioServicesPlaySystemSound(1054)
        
        guard let url = Bundle.main.url(forResource: "winSound", withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Sound error")
        }
        
    }
}
