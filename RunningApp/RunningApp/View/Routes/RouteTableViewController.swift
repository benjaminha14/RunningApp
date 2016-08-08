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
class RouteTableViewController: UITableViewController, CLLocationManagerDelegate, RouteGeneratorDelegate,GMSMapViewDelegate {
    var numberOfRoutesGenerated = 0{
        didSet{
            if(routes.count < 3) {
                initRoutes()
                
                
            }else{
                generating = false
                tableView.reloadData()
            
            }
            
        }
    }
    var location:CLLocation!
    var routeDelegate: RouteGeneratorDelegate!
    var routeGenerator = RouteGenerator()
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
    var routes = [Route]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        
    }
    @IBAction func setupTransition(sender: AnyObject) {
        //routes.removeAll()
        
    }
    override func viewWillAppear(animated: Bool) {
        getUsersLocationSetup()
        print("Route view load")
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToRoutes(segue: UIStoryboardSegue) {}
    
    
}
