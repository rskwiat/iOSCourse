//
//  ViewController.swift
//  Storing-Images
//
//  Created by Robert Skwiat on 7/13/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageArea: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let myURL = NSURL(string: "http://bukk.it/totallylistening.jpg")
        
        let urlRequest = NSURLRequest(URL: myURL!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil{
                println("There was an error")
            } else{
                
                let image = UIImage(data: data)
//                self.imageArea.image = image
                
                var documentsDirectory:String?
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                if paths.count > 0 {
                    
                    documentsDirectory = paths[0] as? String
                    var savePath = documentsDirectory! + "/totallylistening.jpg"
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    self.imageArea.image = UIImage(named: savePath)
                    
                }
                
                
                
                
            }
            
        })*/

        
        var documentsDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            documentsDirectory = paths[0] as? String
            var savePath = documentsDirectory! + "/totallylistening.jpg"
            self.imageArea.image = UIImage(named: savePath)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

