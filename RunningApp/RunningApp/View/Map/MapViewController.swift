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
        drawPolyline("emdcFvsugVL{@FWPHb@DLHHJXn@lDqBv@YXMd@Op@InANtChAxFxApAXB@j@NJc@Z_BPgAb@kDZoCBc@n@sCtAaHd@aEFmCI_Eg@qEyBcLW{BMcCAmFA}GEsHA}EIg|@CePE}EBkDHmAZ_B`@iA|BaEfD}FzAeCjBiDv@eCVuBDeB?sBEaWAoODyCXqGTyJAeJGoGRs@Fi@FOf@WLGr@?`BBN?FMn@?xN?nT?f@?NJB@hL@fS@@yLPcBhC_Id@gAV_@t@i@d@[jAy@nDkCxA}@rBc@hK}ErEqBpCzKHr@FjAExBOvAiAf@aBr@}AV{@?k@Gc@MqAs@s@xBE\\KhB@~CJbARx@f@bBLdB?nBoCAkCBaLByFAq@?OK}AAsI@}SEEBMHg@?oA?wB@gNAyN?o@?EMQ@qAAuA?e@YMKQq@GIAsAKkICcPDmNRqGlBkXv@uJZcE{@Cy@QcBw@}BiAO]O[y@}Di@wA_A_B]s@Ii@HeDCs@ZcCz@kHxB}Qp@gEd@oDJGHKZuB\\oBh@eCl@qCb@mAr@uAp@{@^a@bAq@l@_@hDy@|E{A`CuAbBcBx@kAt@uAzBkE`ImOhD{ErB{BzCiCpDgCxLmIrJoGpL_I`GeEbG{DxCcB|EcC~LqFj@[tAaApBmBd@a@nA{AhB_DrA}CnBuEdAqB~A}BbCiCdBuApAw@jB{@lEcBzBeAxBoAxIqFf@CjAk@`DyAp@QdAAdANvARbAIvBaA{E_OeLyZmH{R~GuEhH{EXr@FP|BdGn@dBoAx@yE`DiMhIyB`Bx@vBf@tAhBvEfC`H`@`Aj@n@`Aj@x@DlC?t@Tl@f@Xj@Vx@s@j@eErDmC`CyB|ACHAJ[P{FvDcDtBuBfAw@ZsDvAu@V{Ar@sBpAiB|AoBtByAxBaB~CgDfI_CzD}@fAoAlAiAx@yAdAiAl@{JfEgFdCsDxBeK|G}GjEwPfL{LnIqFzDqC~BkBjBmBbCkBtCqHlNyDnHiA|AqAlAcBfAy@\\eAToKvBoAl@iA~@UXi@v@k@vAc@dBM`Bc@vFw@xGc@vCKnAQ|BmD~ZcAlJMdA}D|\\aFxb@uBrO}DxT}Hra@sDtR_Iva@wC~O}B|KMl@sKpk@oKvk@kAlGWTMXyA|F[j@UT{CxAi@\\s@z@Uv@IzAfFTt@@`@@vFEdKMbDABfCHjFAZRIRIzE?hB@`@Fv@b@f@d@b@z@Lf@HhA@hAAhDNtBPnB?|AEf_@CnXR~Al@rAt@p@RNK`@Ip@")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
