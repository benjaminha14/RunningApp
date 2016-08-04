//
//  RouteTableViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 7/21/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import GoogleMaps
class RouteTableViewController: UITableViewController, CLLocationManagerDelegate, RouteGeneratorDelegate {
    var numberOfRoutesGenerated = 0{
        didSet{
            if(numberOfRoutesGenerated < 3) {
                tableView.reloadData()
                initRoutes()
                
            }else{
                generating = false
                tableView.reloadData()
            }
            
        }
    }
    var routeDelegate: RouteGeneratorDelegate!
    
    var bump = true
    var initial = true
    var generating = true
    var secondBump = true
    var mapView: GMSMapView!
    var chosenRoute: Route!
    var distanceToAimFor:Double!
    var endLocation:CLLocation!
    var currentLocation:CLLocation?{
        didSet{
            if(initial){
                initRoutes()
            }
        }
    }
    var routes: Results<Route>!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("End Location : \(endLocation)")
        
        
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshRoutes"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        
        getUsersLocationSetup()
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(mapView)
        mapView.myLocationEnabled = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToRoutes(segue: UIStoryboardSegue) {}
    
    
}
