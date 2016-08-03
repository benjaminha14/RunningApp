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

extension RouteTableViewController{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        currentLocation = location
        locationManager.stopUpdatingLocation()
        
        
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
    
    
    func initRoutes(){
        print("Number of routes generated")
        initial = false
        if bump {
            bump = false
            
            print("Initialized maps")
            let marker = GMSMarker()
            
            marker.position =  CLLocationCoordinate2D(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
            
            marker.title = "Your location"
            marker.map = self.mapView
            let routeGenerator = RouteGenerator()
            routeGenerator.endLocation = endLocation
            routeGenerator.setDistance = Int(distanceToAimFor/0.000621371)
            routeGenerator.generateRoute(marker.position, id: "", callBack: {
                print("Add to numberOfRoutesGenerated")
                self.numberOfRoutesGenerated += 1
                self.bump = true
            })
            routes = RealmHelper.retreive()
        }
        
        
    }
    
    
    func refreshRoutes(){
       
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  "toMapView" {
            // Find out how to cast value through this navigation controller
            let mapVC = segue.destinationViewController as! MapViewController
            mapVC.route = chosenRoute
            
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let routes = routes{
            return routes.count
        }else{
            return 0
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RouteCell", forIndexPath: indexPath) as! RouteCell
        let route = routes[indexPath.row]
        
        cell.distance.text = route.totalDistance
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenRoute = routes[indexPath.row]
        performSegueWithIdentifier("toMapView", sender: self)
    }
    
    
    
    
    
    
}