//
//  MapViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 7/13/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
class MapViewController: UIViewController,CLLocationManagerDelegate {
   // var mapView:GMSMapView!
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
  
        drawPolyline("\(route.overViewPath)")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
