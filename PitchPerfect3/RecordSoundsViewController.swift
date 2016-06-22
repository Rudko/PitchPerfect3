//  RecordSoundsViewController.swift
//  PitchPerfect3
//
//  Created by Grigory Rudko on 6/15/16.
//  Copyright © 2016 Grigory Rudko. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoadCalled")
    }

   
    func changeStateOfButtons(buttonLabel: String, enableStopRecordButton: Bool, enableRecordButton: Bool) {
       recordingLabel.text = buttonLabel
        stopRecordingButton.enabled = enableStopRecordButton
        recordButton.enabled = enableRecordButton
    }

    
    @IBAction func recordAudio(sender: AnyObject) {
    print("record button pressed")
        
        changeStateOfButtons("Recording in progress", enableStopRecordButton: true, enableRecordButton: false)
        
        
//        recordingLabel.text = "Recording in progress"
//        stopRecordingButton.enabled = true
//        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder =  AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
    print("stop recording button pressed")


        changeStateOfButtons("Tap to record", enableStopRecordButton: false, enableRecordButton: true)
//        recordingLabel.text = "Tap to Record"
//        stopRecordingButton.enabled = false
//        recordButton.enabled = true
        
    
    audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if (flag) {
     performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print ("Saving of recording failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }        
    }
}

























