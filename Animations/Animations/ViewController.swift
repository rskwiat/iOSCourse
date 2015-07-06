//
//  ViewController.swift
//  Animations
//
//  Created by Robert Skwiat on 7/6/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var counter = 1
    var timer = NSTimer()
    var isAnimating = true

    @IBOutlet var alienImage: UIImageView!
    @IBAction func imageUpdate(sender: AnyObject) {
        if isAnimating == true{
            timer.invalidate()
            isAnimating = false
        } else {
            timer =  NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: ("doAnimation"), userInfo: nil, repeats: true)
            isAnimating = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer =  NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: ("doAnimation"), userInfo: nil, repeats: true)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func doAnimation(){
        if counter == 4 {
            counter = 1
        } else{
            counter++
        }
        
        alienImage.image = UIImage(named: "frame-\(counter).png")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    
    override func viewDidLayoutSubviews() {
//        alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
//        alienImage.alpha = 0;
        alienImage.frame = CGRectMake(100, 20, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(4, animations: { () -> Void in
//            self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y)
//            self.alienImage.alpha = 1
            self.alienImage.frame = CGRectMake(100,20,100,150)
        })
    }*/
    
    


}

