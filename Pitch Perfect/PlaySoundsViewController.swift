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
        
        // stop the audio engine and reset its state
        audioEngine.stop()
        audioEngine.reset()
        
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
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithPitchAndReverbEffect(-1000)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithPitchAndReverbEffect(1000)
    }
    
    func playAudioWithPitchAndReverbEffect(pitch: Float) {
        
        stopButton.hidden = false
        
        // stop playing all audio and reset the audio engine
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        // create a new audio player node
        let player = AVAudioPlayerNode()
        audioEngine.attachNode(player)
        
        // Create the pitch effect
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attachNode(pitchEffect)
        
        // Create the reverb effect but mix it in at 50%
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = 50
        audioEngine.attachNode(reverbEffect)
        
        // connect the player to both effect and the engine's output node
        audioEngine.connect(player, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        // prepare to play
        audioEngine.prepare()

        audioEngine.startAndReturnError(nil)
        
        player.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        player.play()
    }
    
}
