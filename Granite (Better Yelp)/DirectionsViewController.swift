//
//  DirectionsViewController.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/27/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class DirectionsViewController: UIViewController {
    //40.606035, -73.767939
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let camera = GMSCameraPosition.camera(withLatitude: 40.606035, longitude: -73.767939, zoom: 10)
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        view = mapView
        let currentLocation = CLLocationCoordinate2DMake(40.606035, -73.767939)
        let markerPinOnTheMap = GMSMarker(position: currentLocation )
        markerPinOnTheMap.title = "Home"
        markerPinOnTheMap.map = mapView
    }
}

 
