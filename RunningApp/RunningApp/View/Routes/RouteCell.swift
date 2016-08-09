//
//  RouteCell.swift
//  RunningApp
//
//  Created by Ben Ha on 7/21/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import GoogleMaps
class RouteCell: UITableViewCell,CLLocationManagerDelegate {


    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var keyLocations: UILabel!
    var route:Route!
    @IBOutlet weak var map: UIView!
   
    var mapview:GMSMapView!
    
    @IBAction func goToOverview(sender: AnyObject) {
        print(route)
    }
    override var frame: CGRect {
        get{
            return super.frame
        }
        
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 20
            frame.origin.y += 20
            frame.size.height -= 2*20
            frame.size.width -= 2 * 20
            super.frame = frame
        }
    }
}
