//
//  ViewController.swift
//  CoreData-Intro
//
//  Created by Robert Skwiat on 7/13/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //allow us to access data
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
//
//        newUser.setValue("Martha", forKey: "username")
//        newUser.setValue("jail", forKey: "password")
        
//        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username  = %@", "Lilo")
        
        var results = context.executeFetchRequest(request, error: nil)
        println(results)
        
        if results!.count > 0 {
            
//            println(results)
            for result: AnyObject in results! {
                
                if let user = result.valueForKey("username") as? String {
//                    println(user)
                    if user == "Lilo" {
//                        context.deleteObject(result as NSManagedObject)
//                        println(user + " has been deleted")
                        //update passwords
                        result.setValue("password", forKey: "password")
                        
                    }
                }
            }
            context.save(nil)
            
        } else {
            println("No reults")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

