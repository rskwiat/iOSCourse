//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var signupActive = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signUpText: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginText: UIButton!
    
    func displayAlert(title: String, message: String){
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func SignUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in Form", message: "Please enter a username or password")
        
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()

            var errorMessage = "Please try again later"

            var user = PFUser()

            if signupActive == true {
                user.username = username.text
                user.password = password.text
                
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        //Sign up success
                        self.performSegueWithIdentifier("login", sender: self)

                        
                    } else {
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMessage = errorString
                            self.displayAlert("Failed Signup", message: errorMessage)
                        }
                    }
                    
                    
                })
                
            } else {
                PFUser.logInWithUsernameInBackground(username.text, password: password.text, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    println(user)
                    
                    if user != nil {
                        //logged in
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMessage = errorString
                            self.displayAlert("Failed Login", message: errorMessage)
                        }
                    }
                })
            }
            

            
            
        }
        
        
    }
    
    @IBAction func loginIn(sender: AnyObject) {
        
        if signupActive == true {
            signUpText.setTitle("Log In", forState: UIControlState.Normal)
            registeredText.text = "Not Registered?"
            loginText.setTitle("Sign Up", forState: UIControlState.Normal)
            signupActive = false
        } else {
            signUpText.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already Registered?"
            loginText.setTitle("Login", forState: UIControlState.Normal)
            signupActive = true
        }
        
        
    }
    
    
    
    
    
    /*
    @IBAction func createAlert(sender: AnyObject) {
        var alert = UIAlertController(title: "Hey There", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func pause(sender: AnyObject) {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    @IBAction func restore(sender: AnyObject) {
        activityIndicator.stopAnimating()
       //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        println("Image is selected")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
    }
    
    
    @IBAction func importImage(sender: UIButton) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //.camera
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    

    
    @IBOutlet var importedImage: UIImageView! */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*

        var product = PFObject(className: "Products")
        
        product["name"] = "Icey"
        product["description"] = "Marshmellow"
        product["price"] = 4.99
        
        product.saveInBackgroundWithBlock { (success, error) -> Void in
        
        if success == true{
        //                println("success")
        println("Object saved with ID \(product.objectId)")
        } else{
        println("failed")
        println("error")
        }
        }
        
        
        
        
        var query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("FvmQ2fsMWt", block: { (object: PFObject?, error: NSError? ) -> Void in
        if error != nil {
        println(error)
        } else if let product = object {
        product["description"] = "Birthday Cake"
        product["price"] = 2.99
        
        
        product.saveInBackground()
        
        
        //                println(object)
        //                println(object!.objectForKey("description"))
        }
        })


        */
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()?.objectId != nil{
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

