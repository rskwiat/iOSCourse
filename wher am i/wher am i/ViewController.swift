//
//  ViewController.swift
//  wher am i
//
//  Created by Robert Skwiat on 7/7/15.
//  Copyright (c) 2015 robertskwiat. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var labelLatitude: UILabel!
    @IBOutlet var labelLongitude: UILabel!
    @IBOutlet var labelCourse: UILabel!
    @IBOutlet var labelSpeed: UILabel!
    @IBOutlet var labelAltitude: UILabel!
    @IBOutlet var labelAddress: UILabel!
    var manager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLocation:CLLocation = locations[0] as CLLocation
        
        self.labelLatitude.text = "\(userLocation.coordinate.latitude)"
        self.labelLongitude.text = "\(userLocation.coordinate.latitude)"
        
        self.labelCourse.text = "\(userLocation.course)"
        self.labelSpeed.text = "\(userLocation.speed)"
        self.labelAltitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if (error != nil){
                println("error")
            } else {
                if let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark) {
                    var subThoroughfare:String = ""
                    p.country
                    
                    if (p.subThoroughfare != nil) {
                        subThoroughfare = p.subThoroughfare
                    }

                    self.labelAddress.text = "\(subThoroughfare) \n \(p.thoroughfare) \n\(p.subLocality) \n\(p.subAdministrativeArea)\n\(p.postalCode) \(p.country)"

                    
                }
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

