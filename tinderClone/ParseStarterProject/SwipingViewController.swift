//
//  SwipingViewController.swift
//  ParseStarterProject
//
//  Created by Robert Skwiat on 8/31/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    var displayedUserId = ""
    
    
    func wasDragged(gesture: UIPanGestureRecognizer){
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFrameCenter = label.center.x - self.view.bounds.width / 2
        let scale = min(100 / abs(xFrameCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFrameCenter / 200) //2 pi radians...??? less than 6.
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
//                print("Not Chosen" + displayedUserId)
            } else if label.center.x > self.view.bounds.width - 100 {
//                print("Chosen")
                
                acceptedOrRejected = "accepted"
                
            }
            
            if acceptedOrRejected != "" {
                
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayedUserId], forKey:acceptedOrRejected)
                PFUser.currentUser()?.save()
            }
            
            
            
            
            
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            updateImage()
            
        }
    }
    
    
    func updateImage(){
        
        var query = PFUser.query()
        
        if let latitude = PFUser.currentUser()?["Location"]!.latitude {

//            print(latitude)
            
            if let longitude = PFUser.currentUser()?["Location"]!.longitude {

//                print(longitude)
                
                query!.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1), toNortheast:PFGeoPoint(latitude:latitude + 1, longitude: longitude + 1))
            }
            
            
        }
        
        var interestedIn = "male"
        
        if PFUser.currentUser()!["interestedInWomen"]! as! Bool == true {
            interestedIn = "female"
        }
        
        var isFemale = true
        
        if PFUser.currentUser()!["gender"]! as! String == "male" {
            isFemale = false
        }
        
        query!.whereKey("gender", equalTo: interestedIn)
        query!.whereKey("interestedInWomen", equalTo: isFemale)
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["accepted"]  {
            
            ignoredUsers += acceptedUsers as! Array
            
        }
        
        if let rejectedUsers = PFUser.currentUser()?["rejected"] {
            
            ignoredUsers += rejectedUsers as! Array
            
        }

        query!.whereKey("objectId", notContainedIn: ignoredUsers)

        
        query!.limit = 1
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil{
                
                print(error)
                
            } else if let objects = objects as? [PFObject] {
                
                for object in objects {
                    
                    self.displayedUserId = object.objectId!
                    
                    //print(object)
                    
                    let imageFile = object["image"] as! PFFile
                    imageFile.getDataInBackgroundWithBlock{
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else {
                            
                            if let data = imageData {
                                self.userImage.image = UIImage(data:data)
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:" ))
        userImage.addGestureRecognizer(gesture)
        userImage.userInteractionEnabled = true
        
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            
            if let geoPoint = geoPoint {
//            if error == nil {
            
                PFUser.currentUser()?["Location"] = geoPoint
                PFUser.currentUser()?.save()
                
                // do something with the new geoPoint
            }
        }

        
        
        updateImage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logOut" {
            PFUser.logOut()
        }
    }

}
