//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Kevin Bradwick on 01/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioSession: AVAudioSession!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // a session will set the context by which this app will use Audio
        audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordingText.text = "Tap to record"
    }

    @IBAction func startRecording(sender: UIButton) {
        recordingText.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        recordingText.text = "Recording"
        recordingText.hidden = false
        
        // the path to the directory where files can be stored for this app
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        // build the path where the file will be saved
        let fileName = "\(formatter.stringFromDate(NSDate())).wav"
        let filePath = NSURL.fileURLWithPathComponents([dirPath, fileName])
        
        println("Save location: \(filePath)")
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true // allows metering. volume??
        audioRecorder.prepareToRecord()
        audioRecorder.delegate = self
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        stopButton.hidden = true
        recordButton.enabled = true
        
        if audioRecorder.recording {
            audioRecorder.stop()
            audioSession.setActive(false, error: nil)
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if flag == true {
            let recordedAudio = RecordedAudio(url: recorder.url)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Error finishing recording")
            stopButton.hidden = true
            recordButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let controller = segue.destinationViewController as PlaySoundsViewController
            controller.receviedAudio = sender as RecordedAudio
        }
    }
}

