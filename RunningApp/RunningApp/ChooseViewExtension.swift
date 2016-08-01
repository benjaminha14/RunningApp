//
//  ChooseViewExtension.swift
//  RunningApp
//
//  Created by Ben Ha on 7/31/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import Foundation
import GoogleMaps
extension ChooseViewController{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updating location ")
        guard let location = locations.first else { return }
        
        if bump {
            bump = false
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0)
            
            
            print("Initialized maps")
            let marker = GMSMarker()
            
            marker.position =  CLLocationCoordinate2D(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            marker.title = "Your location"
            marker.map = self.mapView
                       
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
    

    

}