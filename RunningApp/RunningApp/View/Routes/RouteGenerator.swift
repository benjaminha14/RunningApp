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
    func generateRoute(coordinate: CLLocationCoordinate2D,id:String){
        
        var waypoints = [Waypoint(coordinate: coordinate, distance: 0,id:id)]
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
            
            generateDirections(finalWaypoints)
            print("Final waypoints chosen")
            print(finalWaypoints)
            
        }
        
        
        
    }
    // Used to work api key: AIzaSyAGA6cWQ99QA0168SrIgLddJZUjVnf5o38
    
    
    func getNearestPlace(coordinate: CLLocationCoordinate2D) {
        let currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\("6000")&key=AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"
        print("Waypoint url")
        print(url)
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
                let actualId:[String] = locations.map{location in
                    let id = location.1["place_id"].stringValue
                    return id
                }
                
                // Calculating distance from current Location
                let distances: [Double] = actualLocation.map { coordinate in
                    let placeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    return currentLocation.distanceFromLocation(placeLocation)
                }
                
                var waypoints = actualLocation.enumerate().map { Waypoint(coordinate: CLLocationCoordinate2D($1), distance: distances[$0],id: actualId[$0]) }
                
                waypoints.sortInPlace { $0.distance > $1.distance }
                var index = waypoints.count-1
                var chosenWaypoint:Waypoint?
                var isChosenWaypoint = true
                chosenWaypoint = waypoints.last
                var sameId = false
                while isChosenWaypoint{
                    if index > 0{
                        if(self.finalWaypoints.count > 0){
                            for finalWaypoint in self.finalWaypoints{
                                if(waypoints[index].id == finalWaypoint.id){
                                    //put something here
                                    sameId = true
                                    
                                }
                            }
                        }
                        
                        if sameId{
                            index -= 1
                            sameId = false
                        }else{
                            
                            chosenWaypoint = waypoints[index]
                            isChosenWaypoint = false
                        }
                    }else{
                        isChosenWaypoint = false
                        chosenWaypoint = waypoints.last
                        //self.totalDistance =2000
                    }
                    
                    
                }
                guard let waypoint = waypoints.first else { fatalError("no waypoints") }
                
                
                self.totalDistance += Int((chosenWaypoint!.distance))
                print("Chosen waypoint \(chosenWaypoint)")
                self.finalWaypoints.append(chosenWaypoint!)
                self.generateRoute((chosenWaypoint!.coordinate,id:chosenWaypoint!.id))
                
                
            case .Failure(let error):
                print(error)
                
            }
        }
    }
    
    func generateDirections(waypoints: [Waypoint]){
        print(waypoints)
        let numberOfRoutes = waypoints.count
        print("List of waypoints \(waypoints)")
        print(waypoints[0].coordinate.longitude)
        
        var coordinates = ""
        for waypoint in waypoints{
            if(waypoint.distance != 0){
                 coordinates += "\(waypoint.coordinate.latitude),\(waypoint.coordinate.longitude)|"
            }
           
        }
        print("Coordinates")
        print(coordinates)
        
        
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json"
        let origin = "\(waypoints[0].coordinate.latitude),\(waypoints[0].coordinate.longitude)"
        let destination = "\(waypoints[0].coordinate.latitude),\(waypoints[0].coordinate.longitude)"
        let waypoints = coordinates
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
    let id:String
}


extension CLLocationCoordinate2D {
    
    init(_ coordinate: Coordinate) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
}

