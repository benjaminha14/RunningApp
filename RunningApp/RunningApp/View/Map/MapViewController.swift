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
        drawPolyline("endcFjvugVVm@TaBFWMISQk@m@a@y@K_@MaAA[?aDHuu@E}@U{BEmAAwFK_A[}@a@k@_@]WO_@Ma@GkB?CcDBbD}C@s@AGGK??gBCcE?uBmE@qBHaABmKHm@?sAGiFOoEKMMIMAMAg@\\Cz@?b@?f@Ed@Mn@_@v@m@lDkB^WLORc@^sAl@}BHYIXm@|BWx@Sn@U\\_@Vm@Z_CnAWRoAx@e@Lg@DcA?y@B?\\EJCJYVuLO@b@pLH`AF~ABfG^pAB~@BZ@tIKrDG~EAn@A?bADlBDnA?lC^KFGr@@|CAdAAx@DZH`@RRNRP`@j@Z|@DVFjA?pFZjDD|@?jEEb^CdT@|@L`AJ^`@x@\\`@`@\\LHGVU`BWl@")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
