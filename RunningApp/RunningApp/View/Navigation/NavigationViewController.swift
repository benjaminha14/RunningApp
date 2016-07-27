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
        mapView.myLocationEnabled = true
        getUsersLocationSetup()
        print(route)
        
        for line in route.allPolylined{
            allPolylines.append(line.individualPolyLines)
        }
        
        for polyline in allPolylines{
            drawPolyline(polyline)
        }
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



