//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Robert Skwiat on 6/27/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        NSUserDefaults.standardUserDefaults().setObject("Rob", forKey: "name")
        
        var name = NSUserDefaults.standardUserDefaults().objectForKey("name")! as String


        
        println(name)
        
        var arry = [1,2,3]
        
//        NSUserDefaults.standardUserDefaults().setObject(arry, forKey: "arya")

        var recalled = NSUserDefaults.standardUserDefaults().objectForKey("arya")! as NSArray
        println(recalled[2])

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

