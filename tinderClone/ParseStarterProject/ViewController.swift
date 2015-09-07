//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class ViewController: UIViewController {

    @IBAction func loginButton(sender: AnyObject) {
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                
                print(error)
                
            } else {
                
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInWomen"]{
                    
                        self.performSegueWithIdentifier("logInUser", sender: self)
                    
                    } else {
                        
                        self.performSegueWithIdentifier("showLoginScreen", sender: self)
                    
                    }

                }
            }
            
        }
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if let username = PFUser.currentUser()?.username {
            
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
                
                self.performSegueWithIdentifier("logInUser", sender: self)

            } else {
                
                self.performSegueWithIdentifier("showLoginScreen", sender: self)

            }
            
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

