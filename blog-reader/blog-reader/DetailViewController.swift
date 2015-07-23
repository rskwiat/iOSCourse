//
//  DetailViewController.swift
//  blog-reader
//
//  Created by Robert Skwiat on 7/22/15.
//  Copyright (c) 2015 Robert Skwiat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let wv = self.webView{
                wv.loadHTMLString("<style>img, iframe{width:100%; margin-bottom: 20px}a{margin-left:0;margin-right:0}.container{width:100%; font-family:'sans-serif'} br{margin-bottom:10px}</style><div class='container'>" + detail.valueForKey("content")!.description + "</div>", baseURL: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

