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
        print("Updating location ")
        guard let location = locations.first else { return }
        
        if bump {
            bump = false
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
            
            
            print("Initialized maps")
            let marker = GMSMarker()
            
            marker.position =  CLLocationCoordinate2D(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            marker.title = "Your location"
            marker.map = self.mapView
            let routeGenerator = RouteGenerator()
            //RouteGenerator.getNearestPlace(marker.position)
            routeGenerator.generateRoute(marker.position,id:"")
          
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
    
}