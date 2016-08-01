//
//  ChooseViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 7/31/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
class ChooseViewController: UIViewController ,CLLocationManagerDelegate{
    var route:Route!
    @IBOutlet weak var mapView: GMSMapView!
    var bump = true
    var currentLocation:CLLocationCoordinate2D?{
        didSet{
            
        }
    }
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.myLocationEnabled = true
        getUsersLocationSetup()
        
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
