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
  
        drawPolyline("}ndcFxnugVa@y@K_@MaAA[?aDBeVDo^E}@U{BEmA@_ECw@K_A[}@a@k@_@]WO_@Ma@GkB?CcDBbD}C@s@AGGK??gBCcE?uB?}C?eC?wDO_@?cD?{A@yG@sBBu@Lm@Ro@JYh@{@{@mAKMUK}@KuCAk@GeA[Pw@n@kDjEuTzBeIf@uArAyCj@s@h@k@`@]n@a@~@]^Iz@O`BCjD??w@`AAFC?cCj@?@cCuCC}BUqA_@yDmAwDiAaJiCqAQmAG{GHeAFcAJ}AVuAZc@LP|@Q}@b@MtA[|AWbAKdAGzGIlAFpAPnDdApDbAvDhAxDlApA^|BTtCBlB?hF@?lE@hJE`BMbFTtH@rCB`ZAjCG~AGbC?bBRpGBl@CbHCdD?dD?hCD|ABn@J\\AdCAlIAtH@fGCn@WzD]rEU~CCjEAdI?lD?zBc@Dq@E{H@SZGR?\\W@GDELAl@?pAMKENArCS`@CRBXDRMKQQ")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
