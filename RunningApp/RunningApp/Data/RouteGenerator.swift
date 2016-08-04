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
import RealmSwift

typealias Coordinate = (latitude: Double, longitude: Double)
protocol RouteGeneratorDelegate {
    func directionFinishedGenerating() -> Void
}
class RouteGenerator {
    var delegate: RouteGeneratorDelegate!
    var startLocation:CLLocation!
    var endLocation:CLLocation!
    var setDistance = 1500
    var totalDistance = 0
    var finalWaypoints:[Waypoint] = [Waypoint]()
    var bump = true
    var routes = [Route]()
    //  var firstItteration = true
    func generateRoute(coordinate: CLLocationCoordinate2D,id:String, callBack:()-> Void){
        
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
            print("Conduct call back")
            callBack()
            generateDirections(finalWaypoints,callBack: {
                print("Add to numberOfRoutesGenerated")
                print("Routese ------")
                print(self.routes)
                self.delegate?.directionFinishedGenerating()
            })
            
            
        }
        
        
        
    }
    // Used to work api key: AIzaSyAGA6cWQ99QA0168SrIgLddJZUjVnf5o38
    
    
    func getNearestPlace(coordinate: CLLocationCoordinate2D) {
        let currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(setDistance)&key=AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"
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
                // Generate random number here
                var diceRoll = Int(arc4random_uniform(UInt32(waypoints.count-1)) + 1)
                index = diceRoll
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
                self.generateRoute(chosenWaypoint!.coordinate,id:chosenWaypoint!.id,callBack: {
                    print("Still gnerating route")
                    
                })
                
                
            case .Failure(let error):
                print(error)
                
            }
        }
    }
    
    func generateDirections(waypoints: [Waypoint],callBack:()-> Void){
        
        
        let numberOfRoutes = waypoints.count
        
        
        
        var coordinates = ""
        for waypoint in waypoints{
            if(waypoint.distance != 0){
                coordinates += "\(waypoint.coordinate.latitude),\(waypoint.coordinate.longitude)|"
            }
            
        }
        
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json"
        let origin = "\(waypoints[0].coordinate.latitude),\(waypoints[0].coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        let waypoints = coordinates
        let mode = "walking"
        let key = "AIzaSyA50D7CCsM-QyTbfPwRTM8zwlC1PL6rRGQ"
        
        let url = "\(baseURL)?origin=\(origin)&destination=\(destination)&waypoints=\(waypoints)&mode=\(mode)&key=\(key)"
        
        let parameters = [
            "origin" : origin,
            "destination" : destination,
            "waypoints" : waypoints,
            "mode":mode,
            "key" : key
        ]
        print("Directions URL ")
        print(url)
        
        
        Alamofire.request(.GET, baseURL, parameters: parameters, encoding: .URL, headers: nil)
            .responseJSON { response in
                
                switch response.result {
                    
                case .Success:
                    let json = JSON(response.result.value!)
                    let route = Route()
                    route.overViewPath = RouteHelper.getOverViewPath(json)
                    route.totalDistance = RouteHelper.getTotalDistance(json)
                    let numberOfLegs = RouteHelper.numberOfLegs(json)
                    for legsIndex in 0..<numberOfLegs{
                        let numberOfStep = RouteHelper.numberOfSteps(json, index: legsIndex)
                        for stepIndex in 0..<numberOfStep{
                            let polyline = Polyline()
                            polyline.individualPolyLines = RouteHelper.getIndividualPoints(json, index: stepIndex, indexOfLeg: legsIndex)
                            let direction = Direction()
                            direction.direction = RouteHelper.getIndividualDirections(json, index: stepIndex, indexOfLeg: legsIndex)
                            
                            route.allPolylined.append(polyline)
                            
                            route.allDirections.append(direction)
                            
                            
                        }
                    }
                    self.routes.append(route)
                    
                    
                    
                case .Failure(let error):
                    print(error)
                    
                }
                
                callBack()
        }
        
    }
    
    
}






