//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Powers, Patrick (US - Orlando) on 2/17/16.
//  Copyright © 2016 Powers, Patrick. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3") {
            player = try! AVAudioPlayer(contentsOfURL: filePath)
            player.enableRate = true
            player.prepareToPlay()
        }else {
            print("Issue getting audio file")
        }
    }

    @IBAction func playSlow(sender: UIButton) {
        playAudio(0.5)
        
    }

    @IBAction func playFast(sender: UIButton) {
        playAudio(1.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
    }
    
    func playAudio(rate : Float) {
        player.stop()
        player.rate = rate
        player.currentTime = 0.0
        player.play()
    }
}
