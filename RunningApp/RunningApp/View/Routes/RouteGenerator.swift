//
//  RouteGenerator.swift
//  RunningApp
//
//  Created by Ben Ha on 7/14/16.
//  Copyright © 2016 Ben Ha. All rights reserved.

import Foundation
import Alamofire
import CoreLocation
import SwiftyJSON

typealias Coordinate = (latitude: Double, longitude: Double)
class RouteGenerator {
    var setDistance = 1500
    var totalDistance = 0
    var finalWaypoints:[Waypoint] = [Waypoint]()
    var bump = true
  //  var firstItteration = true
    func generateRoute(coordinate: CLLocationCoordinate2D){
        
        var waypoints = [Waypoint(coordinate: coordinate, distance: 0)]
        if bump{
            
            finalWaypoints.append(waypoints[0])
        }
        bump = false
        
        if totalDistance < setDistance {
            getNearestPlace(waypoints.last!.coordinate)
            print("In first section")
        }else{
            print("In last section")
            print("Final waypoints\(finalWaypoints.count)")
            if(finalWaypoints.count == 3 ) {
                print("Generating directions")
                generateDirections(finalWaypoints)

            }else{
                setDistance += 100
                getNearestPlace(waypoints.last!.coordinate)
            }
        }
        
        
        
    }
    // Used to work api key: AIzaSyAGA6cWQ99QA0168SrIgLddJZUjVnf5o38
    
    
    func getNearestPlace(coordinate: CLLocationCoordinate2D) {
        let currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(setDistance)&key=AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"

        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                guard let value = response.result.value else { fatalError("BAD. BAD. BAD!") }
                
                let json = JSON(value)
                let name = json["results"][0]["name"].stringValue
                
                let locations = json["results"]
                
                let actualLocation: [Coordinate] = locations.map { location in
                    let latitude = location.1["geometry"]["location"]["lat"].doubleValue
                    let longitude = location.1["geometry"]["location"]["lng"].doubleValue
                    return (latitude: latitude, longitude: longitude)
                }
                
                // Calculating distance from current Location
                let distances: [Double] = actualLocation.map { coordinate in
                    let placeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    return currentLocation.distanceFromLocation(placeLocation)
                }
                
                var waypoints = actualLocation.enumerate().map { Waypoint(coordinate: CLLocationCoordinate2D($1), distance: distances[$0]) }
                waypoints.sortInPlace { $0.distance < $1.distance }
                
                guard let waypoint = waypoints.first else { fatalError("no waypoints") }
                
                
                self.totalDistance += Int((waypoints.last!.distance))
                print("Last waypoints \(waypoints.last)")
                self.finalWaypoints.append((waypoints.last)!)
                self.generateRoute((waypoints.last!.coordinate))
                
                
            case .Failure(let error):
                print(error)
                
            }
        }
    }
    
    func generateDirections(waypoints: [Waypoint]){
        print("List of waypoints \(waypoints)")
        print(waypoints[0].coordinate.longitude)
        
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json"
        let origin = "\(waypoints[0].coordinate.latitude),\(waypoints[0].coordinate.longitude)"
        let destination = "\(waypoints[0].coordinate.latitude),\(waypoints[0].coordinate.longitude)"
        let waypoints = "\(waypoints[1].coordinate.latitude),\(waypoints[1].coordinate.longitude)|\(waypoints[2].coordinate.latitude),\(waypoints[2].coordinate.longitude)"
        let mode = "walking"
        let key = "AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"
        
        let url = "\(baseURL)?origin=\(origin)&destination=\(destination)&waypoints=\(waypoints)&key=\(key)"
        
       // let url = "https://maps.googleapis.com/maps/api/directions/json?origin=37.442621379972245,-121.90352189273266&destination=37.442621379972245,-121.90352189273266&waypoints=37.446312800000008,-121.89543329999999|via:37.4375122,-121.8956883&key=AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"
        print("THIS IS THE DIRECTIONS URL")
        print(url)
        
        let parameters = [
            "origin" : origin,
            "destination" : destination,
            "waypoints" : waypoints,
            "key" : key
        ]
        
        // let req = Alamofire.request(.GET, baseURL, parameters: parameters, encoding: .URL, headers: nil)
        // debugPrint(req)
        
        Alamofire.request(.GET, baseURL, parameters: parameters, encoding: .URL, headers: nil)
                    .responseJSON { response in
            print("response \(response))")
            print("URL final \(url)")
        
            switch response.result {
            
            case .Success:
                print("Alamo fire url \(url)")
               
                let json = JSON(response.result.value!)
             //   let arrayOfDirections = json["routes"]
                print("Directions \(json)")
                let legs = json["routes"][0]["legs"][0]
                let distanceOfRun = legs["text"]
                let steps = legs["steps"]
                print("Distance")
                print(distanceOfRun)
                print("Text directions")
                for (var i = 0; i < steps.count; i+=1){
                    print(steps[i]["html_instructions"])
                }
                
            case .Failure(let error):
                print(error)
                
            }
        }
    }
    
}

struct Waypoint{
    let coordinate:CLLocationCoordinate2D
    let distance:Double
}


extension CLLocationCoordinate2D {
    
    init(_ coordinate: Coordinate) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
}

