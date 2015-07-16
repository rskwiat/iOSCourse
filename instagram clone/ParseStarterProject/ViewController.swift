//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupActive = true
    
    @IBOutlet var userName: UITextField!

    @IBOutlet var password: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func displayAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func logIn(sender: AnyObject) {
        
        if signupActive == true {
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            registeredText.text = "Not registered?"
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signupActive = false
        } else {
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already registered?"
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            signupActive = true
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        if userName.text == "" || password == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")

        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//            activityIndicator.backgroundColor = "
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
  
            var errorMessage = "Please try again later"

            
            if signupActive == true {
            
                var user = PFUser()
                user.username = userName.text
                user.password = password.text
                
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil{
                        //sign up was successful
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        if let errorString = error.userInfo?["error"] as? String {
                            errorMessage = errorString
                        }
                        
                        self.displayAlert("Failed Signup", message: errorMessage)
                        
                        
                    }
                    
                })
            } else {
                
                PFUser.logInWithUsernameInBackground(userName.text, password: password.text, block: { (user, error) -> Void in
                    
                    if user != nil {
                        //logged in
                        
                        self.performSegueWithIdentifier("login", sender: self)

                        
                    } else {
                        
                        if let errorString = error.userInfo?["error"] as? String {
                            errorMessage = errorString
                        }
                        
                        self.displayAlert("Failed Signup", message: errorMessage)
                    }
                    
                })
                
                
            }
            
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

