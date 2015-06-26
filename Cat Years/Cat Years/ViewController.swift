 //
//  ViewController.swift
//  Cat Years
//
//  Created by Robert Skwiat on 6/24/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var catsAgeInput: UITextField!
    @IBAction func calculateAgeButton(sender: AnyObject) {

        var enteredAge = catsAgeInput.text.toInt()

        if enteredAge != nil {
            var catYears = enteredAge! * 7
            outputLabel.text = "Your cat is: \(catYears) in cat years"
        } else {
            outputLabel.text = "Please enter an age."
        }
        
     
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

