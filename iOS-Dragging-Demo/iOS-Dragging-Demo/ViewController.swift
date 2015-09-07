//
//  ViewController.swift
//  iOS-Dragging-Demo
//
//  Created by Robert Skwiat on 8/31/15.
//  Copyright © 2015 com.robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
        label.text = "Drag Me"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:" ))
        label.addGestureRecognizer(gesture)
        label.userInteractionEnabled = true
        
        
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer){
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFrameCenter = label.center.x - self.view.bounds.width / 2
        let scale = min(100 / abs(xFrameCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFrameCenter / 200) //2 pi radians...??? less than 6.
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if label.center.x < 100 {
                print("Not Chosen")
            } else if label.center.x > self.view.bounds.width - 100 {
                print("Chosen")
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

