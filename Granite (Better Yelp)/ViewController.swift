//
//  ViewController.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/22/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    // Map
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var tasksTextField: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        // So essentially what we are doing is that we are creating a new let constant called location and setting that equl to the locations array and the very first element by setting the index value we want equal to 0 the reason we want the very first element is becuase we want the users most recent position, and the reason it is the first one rather than the last one because the array can also be populated with elements that we do not care about therefore we only care about the users most updated location therefore it would be the very first element of the array
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        // So what is essentially happening in these lines of code is that so fist of all we have to gove the coordinates a span of how far we want the location to cover so we set both the latitude and longitude equal to 0.01 this is just coordinational jargon that is not neccesary to understand
        
        // In the nex line of code what we are essentially doing is that we are saying that our 2d location eaning the zooming ability is that we want it to reference the latitude and longitude spans that we declared in he previous line of code and we set that equal to 0.01 thefore that makes sense we only want to be able to zoom in at a span of 0.01 north east south and west
        
        // So basically what is happening is that we are combining the to let constants previously declare din this third line of code and essentially what is happening is the we are combining the data that covers the span of the users locations as well as the ability to zoom in the users locations span and therefore making it the region
        
        map.setRegion(region, animated: true)
        // So basically in this line of code we are setting the region where as we declared it in the line previous to this code
        
        self.map.showsUserLocation = true
        //print(location.altitude) // This is optional if you want to know the users current altitude
    }
    // But essentially this function will b
    
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // So essentially what is happening in the first4 lines of these manager methods is that we are letting this class receive update eventes by using the proper method and then setting it equal to self
        
        // In the next line of code we are saying that we want the desired accuracy of manager and as we know manager refers to our locationd data so essentially what we are saying is that we want the accuracy for this location data to always be at its best
        
        // In the next line of code what we are essentially doing is that we are telling our location data whic is stored in our let constant called manager that since we are using the users location we want to ask for authorization whenever they are using the app therefore we are requesting their authorization to use their location whenver they start to use the app
        
        // In the last line of code what we are essentially doing is that we want to update their location based on the amount of times we call this function therefore we would only call this function once
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

