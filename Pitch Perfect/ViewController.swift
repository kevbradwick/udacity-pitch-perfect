//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Kevin Bradwick on 01/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingText: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecording(sender: UIButton) {
        recordingText.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingText.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

