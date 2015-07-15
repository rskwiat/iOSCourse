//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        }*/
        
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
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

