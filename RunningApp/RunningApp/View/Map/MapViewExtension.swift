//
//  MapViewExtension.swift
//  RunningApp
//
//  Created by Ben Ha on 7/13/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import Cartography
extension MapViewController{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
       
        guard let location = locations.first else { return }
        
        if bump {
            bump = false
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0)

            
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            let routeGenerator = RouteGenerator()
    
           
          
        }
       
    }
    
    func getUsersLocationSetup(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            print("Got permision to get location")
        }
    }
    
    func drawPolyline(route:String){
        let path:GMSPath = GMSPath(fromEncodedPath: route)!
        let route = GMSPolyline(path: path)
        route.map = mapView
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  "toNavigationView" {
            let navController = segue.destinationViewController as! UINavigationController
            let directionsVC = navController.viewControllers.first as! NavigationViewController
            directionsVC.route = route
            
            
        }
    }
    
    
}