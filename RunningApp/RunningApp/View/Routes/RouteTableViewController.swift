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
class RouteTableViewController: UITableViewController, CLLocationManagerDelegate {
    var numberOfRoutesGenerated = 0{
        didSet{
            tableView.reloadData()
        }
    }
    var bump = true
    var secondBump = true
    var mapView: GMSMapView!
    var chosenRoute: Route!
    var currentLocation:CLLocation?{
        didSet{
            if secondBump{
                for i in 0...3{
                    initRoutes()
                }
                secondBump = false
            }
        }
    }
    var routes: Results<Route>!{
        didSet{
            print("Routes")
            initRoutes()
            tableView.reloadData()
        }
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
