//
//  ViewController.swift
//  bach to bach
//
//  Created by Robert Skwiat on 7/9/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var sliderVolume: UISlider!
    @IBOutlet var playPause: UIBarButtonItem!
    @IBOutlet var stop: UIBarButtonItem!
    
    @IBOutlet var toolbar: UIToolbar!
    var state: Int = 1
    
    
    @IBAction func playPause(sender: AnyObject) {
        
        println(sender.tag)
        if sender.tag == 1{
            state = 1
        } else if sender.tag == 0{
            state = 0
        }
        
        var toggleButton: UIBarButtonItem
        var items = toolbar.items!
        
        if state == 0 {
            toggleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playPause:")
            toggleButton.tag = 1
            items[0] = toggleButton
        } else if state == 1 {
            toggleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playPause:")
            toggleButton.tag = 0
            items[0] = toggleButton
            state = 0
        } else{
            println("Some other error")
        }
        
        toolbar.setItems(items, animated: true)
        
        if sender.tag == 1{
            player.play()
            stop.enabled = true
        } else if sender.tag == 0{
            player.pause()
        }
    }

    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        stop.enabled = false
        player.currentTime = 0
        state = 0
        if playPause.tag == 1{
            playPause.tag = 0
            playPause(playPause)
        }
        
    }
    
    
    var player:AVAudioPlayer = AVAudioPlayer()

    
    
    @IBAction func sliderValue(sender: AnyObject) {
        player.volume = sliderVolume.value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        var audioPath = NSBundle.mainBundle().pathForResource("bach1", ofType: "mp3")
        var error:NSError? = nil
        
        
        player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!), fileTypeHint: "mp3", error: &error)

   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

