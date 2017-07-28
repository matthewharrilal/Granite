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
    var mapView: GMSMapView?
    
    var secondMapView: GMSMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let camera = GMSCameraPosition.camera(withLatitude: 40.606035, longitude: -73.767939, zoom: 10)
        mapView = GMSMapView.map(withFrame: frame, camera: camera)
        view = mapView
        let currentLocation = CLLocationCoordinate2DMake(40.606035, -73.767939)
        let markerPinOnTheMap = GMSMarker(position: currentLocation )
        markerPinOnTheMap.title = "Home"
        markerPinOnTheMap.map = mapView
        // markerPinOnTheMap.icon
        // we can use this later this is for customization
        
        
        // So what we are essentially doing right now is that we are creating a pin on our map view that pins our exact coordinates at homevvvvv
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next" )
        
        // 40.718448, -74.002527
        let frame1 = CGRect(x: 0, y: 0, width: 20, height: 20)
        let camera1 = GMSCameraPosition.camera(withLatitude: 40.718448, longitude:  -74.002527, zoom: 10)
        //      view = secondMapView // dont need this there is ionly one view
        let currentLocation1 = CLLocationCoordinate2DMake( 40.718448,  -74.002527)
        let markerPinOnTheMap1 = GMSMarker(position: currentLocation1 )
        markerPinOnTheMap1.title = "Make School"
        markerPinOnTheMap1.map = mapView
        
        
        let origin = "\(40.606035),\(-73.767939)"
        let destination = "\(40.718448),\(-74.002527)"
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\("\(40.606035),\(-73.767939)")&destination=\("\(40.718448),\(-74.002527)")&mode=driving&key=API_KEY"
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\("\(40.606035),\(-73.767939)")&destination=\("\(40.718448),\(-74.002527)")&mode=driving&key=API_KEY")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let routes = json["routes"] as! NSArray
                    self.mapView?.clear()
                    
                    OperationQueue.main.addOperation({
                        for route in routes
                        {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            
                            let bounds = GMSCoordinateBounds(path: path!)
                            self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                            
                            polyline.map = self.mapView
                            
                        }
                    })
                }catch let error as NSError{
                    print("error:\(error)")
                }
            }
        }).resume()
    }
    
    
    
    
    
    
    // func next() {
    
    // let nextLocation = CLLocationCoordinate2DMake(37.785834, -122.406417)
    //mapView?.camera = GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 15)
}



