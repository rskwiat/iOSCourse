//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Robert Skwiat on 6/25/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var guess: UITextField!
    
    @IBAction func guessButton(sender: AnyObject) {
        
        var randomNumber:UInt32 = arc4random_uniform(6)
        
        var guessInt = guess.text.toInt()
        
        if guessInt != nil {
            
            if ( Int(randomNumber) == guessInt ){
                resultsLabel.text = "You win!"
            } else {
                resultsLabel.text = "You lost my number was \(randomNumber)"
            }
            
        } else {
            resultsLabel.text = "Please enter a number 0 to 5"
        }
        
    }
    
    @IBOutlet var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

