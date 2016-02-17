//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Powers, Patrick (US - Orlando) on 2/17/16.
//  Copyright © 2016 Powers, Patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        print("in recordAudio")
        recordingInProgress.hidden = false
        stopButton.hidden = false
        
    }

    @IBAction func stopRecord(sender: UIButton) {
        print("Stop Recording")
        stopButton.hidden = true
    }
}

