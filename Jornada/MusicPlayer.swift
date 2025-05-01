//
//  Untitled 2.swift
//  Journada
//
//  Created by Aaron Thomas on 4/25/25.
//import SwiftUI
import AVFoundation
var music: AVAudioPlayer?

func loadAndPlayMusic() {
    if let musicURL = Bundle.main.url(forResource: "puzzlegame", withExtension: "mp3") {
        do {
            music = try AVAudioPlayer(contentsOf: musicURL)
            music?.numberOfLoops = -1
            music?.volume=1.0
            music?.play()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                music?.setVolume(0, fadeDuration: 3.5)
            }
            
        } catch {
            print("Error loading music file.")
        }
    } else{
        print("Error could not find music file")
    }
    
}
