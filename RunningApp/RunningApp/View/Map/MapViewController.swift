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
        drawPolyline("}mdcF|ougV[[Uc@Wo@Oy@CeA@eQFe]?iJ_@kEAaC?uBC}@SiAc@{@YW[YYO]Kg@EqC@_DAGGK?AkDAgE?m@[?mC?mBHmHLiF@c@AwNa@SSCMCQ?]NAVA^?fAAf@Gr@]x@k@z@k@pBeAb@WNOT]b@{Az@cDlFyXhBuJXwBDu@b@qCd@gCtB}Kr@qEPuAhAoIFo@Aq@Ee@M]O[U][W[QUI[EaG@}BCw@@g@Fq@R[Pw@f@w@`Am@l@OJEBMAMEMES[MYOSWsAj@Wo@yC?QHIzBs@pDq@`@C?aAdAGzGIf@BJPLFlAVh@ThAp@hBlAXb@Pj@Hf@@h@KbAkCrREb@@RBNkDdRqCnOwGt]Kl@SNIJ[jAs@xCUv@]d@WTqB~@i@XUL[\\i@p@KZKdAAf@xCPpAB~@BZ@tIKrDG~EAn@A?bADlBDnA?lC^KFGr@@|CAdAAx@DZH`@RRNRP`@j@Z|@DVFjA@`BAnCZjDD|@?jEEb^AbVL`AJ^`@x@\\`@@@")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
