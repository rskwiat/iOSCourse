//
//  ViewController.swift
//  Stop Watch
//
//  Created by Robert Skwiat on 6/26/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    var count = 0

    @IBOutlet var playBarButton: UIBarButtonItem!
    
    @IBOutlet var time: UILabel!
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        count = 0
        time.text = "0"
    }

    @IBAction func play(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)

    }
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    func updateTime(){
        count++
        time.text = "\(count)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

