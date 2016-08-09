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

extension RouteTableViewController {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        self.location = location
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
            routeGenerator.delegate = self
            routeGenerator.endLocation = endLocation
            routeGenerator.setDistance = Int(distanceToAimFor/0.000621371)
            routeGenerator.generateRoute(marker.position, id: "", callBack: {
                
                print("Add to numberOfRoutesGenerated")
                
                
                
            })
            
        }
        
        
    }
    

    func refreshRoutes(){
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  "toMapView" {
            let navVC = segue.destinationViewController as! UINavigationController
            let mapVC = navVC.viewControllers.first as! MapViewController
            mapVC.route = chosenRoute
        }
    }
    
    func directionFinishedGenerating() -> Void {
        self.bump = true
//        routeGenerator.bump = true
//        routeGenerator.finalWaypoints.removeAll()
//        routeGenerator.routes.removeAll()
        print("Add to numberOfRoutesGenerated")
        
        
        var sameRoute = false
        if(routes.count >= 1) {
            for route in self.routes{
                if route == self.routeGenerator.finalRoute{
                    sameRoute = true
                }
            }
        }else{
            self.routes.append(self.routeGenerator.finalRoute)
            routeGenerator = RouteGenerator()
            self.numberOfRoutesGenerated += 1
            return
        }
        if sameRoute != true{
            self.routes.append(self.routeGenerator.finalRoute)
           
        }
        routeGenerator = RouteGenerator()
        self.numberOfRoutesGenerated += 1
        
        
    }
    
    func drawPolyline(route:String){
        let path:GMSPath = GMSPath(fromEncodedPath: route)!
        let route = GMSPolyline(path: path)
        route.map = mapView
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return routes.count
        
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RouteCell", forIndexPath: indexPath) as! RouteCell
        let route = routes[indexPath.row]
        
        let camera = GMSCameraPosition.cameraWithLatitude(location.coordinate.latitude,
                                                          longitude: location.coordinate.longitude, zoom: 12)
        var frame = CGRectZero
        frame.size.width = cell.map.frame.size.width
        frame.size.height = cell.map.frame.size.height
        cell.mapview = GMSMapView.mapWithFrame(frame, camera: camera)
        cell.route = route
        cell.mapview.delegate = self
        cell.mapview.myLocationEnabled = true
        cell.mapview.settings.allowScrollGesturesDuringRotateOrZoom = true
        cell.mapview.settings.zoomGestures = false
        cell.mapview.settings.scrollGestures = false
        
        
        
        let path:GMSPath = GMSPath(fromEncodedPath: route.overViewPath)!
        let route2 = GMSPolyline(path: path)
        route2.map = cell.mapview
       // cell.map.backgroundColor = UIColor.clearColor()
            cell.distance.layer.masksToBounds = true
        //cell.distance.layer.cornerRadius = 9
        cell.distance.text = route.totalDistance
        cell.distance.layer.cornerRadius = 4
        cell.distance.backgroundColor = UIColor(red: UIColor.getValue(29.0), green: UIColor.getValue(53.0), blue: UIColor.getValue(87.0), alpha: 0.3)
        cell.map.layer.masksToBounds = true
        cell.map.layer.cornerRadius = 5
        cell.map.layer.shadowRadius = 1
        cell.map.layer.shadowColor = UIColor.blackColor().CGColor
        cell.map.addSubview(cell.mapview)
        
        cell.delegate = self
        

        

    
        return cell
    }
    
    func retreiveChosenRoute(route: Route) {
        chosenRoute = route
        performSegueWithIdentifier("toMapView", sender: self)
    }
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenRoute = routes[indexPath.row]
        performSegueWithIdentifier("toMapView", sender: self)
    }
    
    
    
    
    
    
}