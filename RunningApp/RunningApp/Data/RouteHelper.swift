//
//  RouteHelper.swift
//  RunningApp
//
//  Created by Ben Ha on 7/21/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import Foundation
import SwiftyJSON
class RouteHelper{
    static func getTotalDistance(json:JSON)-> String {
        return json["routes"][0]["legs"][0]["distance"]["text"].string!
        
    }
    
    static func getOverViewPath(json:JSON)-> String {
        
        let steps = json["routes"][0]["overview_polyline"]["points"]
        return steps.string!
    }
    
    static func getIndividualPoints(json:JSON,index:Int, indexOfLeg:Int )-> String {
        print(index)
        let legs = json["routes"][0]["legs"]
        let steps = legs[indexOfLeg]["steps"][index]["polyline"]["points"]
        return steps.string!
        
        
    }
    
    static func getIndividualDirections(json:JSON,index:Int,indexOfLeg:Int )-> String {
        print(index)
        let legs = json["routes"][0]["legs"]
        let directions = legs[indexOfLeg]["steps"][index]["html_instructions"]
        return directions.string!
        
        
    }
    
    static func numberOfSteps(json:JSON,index:Int)-> Int {
        let legs = json["routes"][0]["legs"]
        let stepsCount = legs[index]["steps"].count
        return stepsCount
    }
    
    
    static func numberOfLegs(json:JSON)-> Int {
        let leg = json["routes"][0]["legs"].count
        return leg
    }
    
    
}
