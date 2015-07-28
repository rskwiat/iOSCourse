//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    
    
    
    @IBOutlet var importedImage: UIImageView!

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

