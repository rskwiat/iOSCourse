//
//  ViewController.swift
//  webView-Demo
//
//  Created by Robert Skwiat on 7/13/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        
        var url = NSURL(string: "https://google.com")
        
        var request = NSURLRequest(URL: url!)
        
        webview.loadRequest(request)
        */
        
        // Do any additional setup after loading the view, typically from a nib.
        
        var html = "<html><head></head><body><h1>Hello World</h1></body></html>"
        
        webview.loadHTMLString(html, baseURL: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

