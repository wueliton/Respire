//
//  AudioPlayer.swift
//  Restart
//
//  Created by Paulo Wueliton on 14/11/21.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    var fileName = ""
    var fileType = ""
    var audioPlayer: AVAudioPlayer?
    var url: URL?

    func playSound() {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.delegate = self
                audioPlayer?.play()
            } catch {
                print("Could not play the sound file.")
            }
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully: Bool) {
        @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
        isOnBoardingViewActive = true
    }
}
