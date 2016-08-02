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
        currentLocation = locations.last?.coordinate
        guard let location = locations.first else { return }
        // Remove the bump to have the camera focuse on you 
        if bump {
            bump = false
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0)
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