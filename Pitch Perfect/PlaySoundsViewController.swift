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
    var receievedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = try! AVAudioPlayer(contentsOfURL: receievedAudio.filePathUrl)
        player.enableRate = true
        player.prepareToPlay()
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading:receievedAudio.filePathUrl)

    }

    @IBAction func playSlow(sender: UIButton) {
        playAudio(0.5)
        
    }

    @IBAction func playFast(sender: UIButton) {
        playAudio(1.5)
    }
    
    @IBAction func playChipmunk(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playReverb(sender: UIButton) {
        playAudioWithReverb(100)
    }
    
    @IBAction func playEcho(sender: UIButton) {
        playAudioWithEcho(NSTimeInterval(0.5))
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stop()
        
    }
    
    func stop(){
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    func playAudio(rate : Float) {
        player.stop()
        player.rate = rate
        player.currentTime = 0.0
        player.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch

        getNodeAndPlayWithSoundEffect(changePitchEffect)
    }
    
    func playAudioWithReverb(mix: Float){

        let reverb = AVAudioUnitReverb()
        reverb.wetDryMix = mix
        reverb.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        
        getNodeAndPlayWithSoundEffect(reverb)
    }
    
    func playAudioWithEcho(timeInterval: NSTimeInterval){
        
        let echo = AVAudioUnitDelay()
        echo.delayTime = timeInterval
        
        getNodeAndPlayWithSoundEffect(echo)
    }

    
    func getNodeAndPlayWithSoundEffect(soundEffect: AVAudioNode){
        
        stop()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(soundEffect)
        
        audioEngine.connect(audioPlayerNode, to: soundEffect, format: nil)
        audioEngine.connect(soundEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    }
