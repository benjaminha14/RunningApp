//
//  NavigationViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 7/26/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class NavigationViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate {
    var bump = true
    var color:UIColor = UIColor.redColor()
    @IBOutlet weak var tableView: UITableView!
    // var mapView:GMSMapView!
    var route:Route!
    var allPolylines = [String]()
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: UIColor.getValue(238), green: UIColor.getValue(238), blue: UIColor.getValue(238), alpha: 1.0)
        mapView.myLocationEnabled = true
        getUsersLocationSetup()
        
        if RealmHelper.isChosenRoute(){
            route = RealmHelper.retreive()
        }
        print(route)
        
        for line in route.allPolylined{
            allPolylines.append(line.individualPolyLines)
        }
        
        for polyline in allPolylines{
            drawPolyline(polyline)
        }
  
    }
    
    @IBAction func endRun(sender: AnyObject) {
        RealmHelper.nuke()
        performSegueWithIdentifier("goToMain", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



