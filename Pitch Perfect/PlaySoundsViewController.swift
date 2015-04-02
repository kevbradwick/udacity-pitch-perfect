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
    
    var receviedAudio: RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var error: NSError?
        
        stopButton.hidden = true
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receviedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
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
}
