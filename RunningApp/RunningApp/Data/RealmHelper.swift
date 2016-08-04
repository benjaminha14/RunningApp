//
//  RealmHelper.swift
//  RunningApp
//
//  Created by Ben Ha on 7/20/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import Foundation
import RealmSwift
class RealmHelper{
    static func retreive() -> Route{
        let realm = try! Realm()
        let list = realm.objects(Route).sorted("totalDistance", ascending: false)
        return list.first!
    }
    
    static func isChosenRoute() -> Bool {
      do {
            let realm = try Realm()
            let route = realm.objects(Route).sorted("totalDistance",ascending: false)
            if (route.count > 0){
                return true
            }
            
        }catch{
            return false
        }
        
        return false
        
    }
    
    static func add(route:Route) {
        let realm = try! Realm()
        try! realm.write({
            realm.add(route)
        })
    }
    static func nuke(){
        let realm = try! Realm()
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
        
        
    }
    
    static func addPolyline(route:Polyline) {
        let realm = try! Realm()
        try! realm.write({
            realm.add(route)
        })
    }
    
}


