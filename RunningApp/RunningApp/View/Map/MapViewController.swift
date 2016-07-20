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
//          initalizeGoogleMaps()   
        drawPolyline("endcFtougVW[a@y@K_@MaAA}@BeTDc^?kEE}@[kD@oCAaBGkAEW[}@a@k@SQSOa@S[Iy@EeA@CcDBbD}C@s@AGGK??gBCcE?uBgAA{CD}CJcLHc@AqHUoEKMMIMAMAg@x@CbA?f@Ed@MnAy@VS~BoAl@[^WT]Ro@dAwDHYIXm@|B_@rASb@MN_@VmDjBw@l@o@^e@Lg@Dc@?{@?]B?\\EJCJYVuLO@b@pLH`AF~ABfG^rABhAB`@@vNS~EAn@A?bADlBDnA?lC^KFGr@@|CAjB?`@F^LVN^\\`@j@Z|@J~@Bv@A~DDlATzBD|@En^Cf[@ZL`AJ^`@x@VZ")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
