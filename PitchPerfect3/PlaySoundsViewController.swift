//
//  PlaySoundsViewController.swift
//  PitchPerfect3
//
//  Created by Grigory Rudko on 6/16/16.
//  Copyright © 2016 Grigory Rudko. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    //
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var player: AVAudioPlayer! //
    
   
    
    
    
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    
    
    
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
    print("Play Sound Button Pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("PlaySoundsViewController loaded")
        setupAudio()
        
        let asset = AVURLAsset(URL: recordedAudioURL, options: nil)
        let audioDuration = asset.duration
        let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
        durationLabel.text = "\(audioDurationSeconds)"
        // convert into minutes
    
        
      /*  let sound: AVAudioPlayer!
        var duration: NSTimeInterval {
            get {
                if let nonNilsound = sound {
                    durationLabel.text =  "\(nonNilsound.duration)"
                }
                return 0.0
            }
        }*/
        
        
        
        
    }

    /* override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying) 
        
        // MARK: - I guess this is a right place for a code providing duration of the recorded sound and transfering it to durationLabel. UPD: ACTUALLY IT SHOULD BE IN viewDidLoad()
    } */

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}






