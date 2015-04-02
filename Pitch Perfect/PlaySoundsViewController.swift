//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Kevin Bradwick on 01/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var receviedAudio: RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var error: NSError?
        
        stopButton.hidden = true
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receviedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receviedAudio.filePathUrl, error: nil)
    }

    func playAudio(atSpeed speed: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = speed
        audioPlayer.play()
        stopButton.hidden = false
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(atSpeed: 0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(atSpeed: 1.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopButton.hidden = true
        audioPlayer.stop()
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithPitch(-1000)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithPitch(1000)
    }
    
    func playAudioWithPitch(pitch: Float) {
        stopButton.hidden = false
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attachNode(pitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
}
