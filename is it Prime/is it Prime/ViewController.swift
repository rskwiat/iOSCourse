//
//  ViewController.swift
//  is it Prime
//
//  Created by Robert Skwiat on 6/26/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultsLabel: UILabel!
    
    @IBOutlet var userNumber: UITextField!
    
    @IBAction func primeButton(sender: AnyObject) {
        var numberInt = userNumber.text.toInt();
        var isPrime = true;
        
        if numberInt != nil{
            
            var unWrapped = numberInt!
            
            if unWrapped == 1{
                isPrime = false
            }
            
            if unWrapped != 2 && unWrapped != 1{
                
                for var i = 2; i < unWrapped; i++ {
                    
                    if unWrapped % i == 0 {
                        isPrime = false;
                    }
                    
                }
            }
            
            if isPrime == true {
                resultsLabel.text = "\(unWrapped) is Prime"
            } else {
                resultsLabel.text = "\(unWrapped) is not Prime"
   
            }
            
            
        } else {
            resultsLabel.text = "Please enter a number"
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

