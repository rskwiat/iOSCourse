//
//  ViewController.swift
//  Controlling the keyboard
//
//  Created by Robert Skwiat on 6/30/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var inputConnection: UITextField!
    
    @IBOutlet var updateLabel: UILabel!
    
    @IBAction func updateButton(sender: AnyObject) {
        updateLabel.text = inputConnection.text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputConnection.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
    
        textField.resignFirstResponder()
        
        return true
    
    }


}

