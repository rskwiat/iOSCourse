//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
    }

    @IBAction func restore(sender: AnyObject) {
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    @IBAction func createAlert(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Hey there", message: "Are you sure you want to use this?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: { (action) -> Void in
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
    
    @IBOutlet var importedImage: UIImageView!
    
    @IBAction func importImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //change to camera for camera access
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gettting images from camera / photostream
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        /*
        var product = PFObject(className: "Products")
        
        product["name"] = "Ice Cream"
        product["description"] = "Phish Food"
        product["price"] = "4.99"
        
        product.saveInBackgroundWithBlock { (success, error) -> Void in
            if success == true{
//                println("Sucessful")
                
                println("object has been saved with ID \(product.objectId)")
            } else{
                println("fail")
                println(error)
            }
        }
        
        var query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("L21LmAIEjc", block: { ( object: PFObject?, error: NSError?) -> Void in
            if error != nil{
                println(error)
            } else if let product = object {
                
                product["description"] = "Rocky Road"
                product["price"] = "2.99"
                
                product.saveInBackground()
                
                //println(object!.objectForKey("description"))
            }
        })*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

