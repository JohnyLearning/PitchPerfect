//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Ivan Hadzhiiliev on 2019-12-01.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, high, low, echo, reverb}
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .high:
            playSound(pitch: 1000)
        case .low:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        case .none:
            playSound()
        }
        
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fix the buttons to not being stretched - https://stackoverflow.com/questions/38697032/how-to-center-an-image-inside-an-uibutton-without-stretching-in-both-direction-i
        fixButtons(buttons: [slowButton, fastButton, highPitchButton, lowPitchButton, echoButton, reverbButton])
        setupAudio()
    }
    
    private func fixButtons(buttons: Array<UIButton>)  {
        for button in buttons {
            button.contentMode = .center
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(PlayingState.notPlaying)
    }

}
