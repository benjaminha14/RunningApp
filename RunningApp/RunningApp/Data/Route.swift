//
//  Route.swift
//  RunningApp
//
//  Created by Ben Ha on 7/20/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import Alamofire
class Route:Object{
    dynamic var overViewPath:String = ""
    dynamic var totalDistance = "0 miles"
    let allPolylined = List<Polyline>()
    let allDirections = List<Direction>()

}

class Polyline: Object {
    dynamic var individualPolyLines = ""
}

class Direction: Object {
    dynamic var direction = ""
}

