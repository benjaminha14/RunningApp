//
//  Waypoint.swift
//  RunningApp
//
//  Created by Ben Ha on 7/21/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//
import MapKit
import Foundation
struct Waypoint{
    let coordinate:CLLocationCoordinate2D
    let distance:Double
    let id:String
}

extension CLLocationCoordinate2D {
    
    init(_ coordinate: Coordinate) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
}