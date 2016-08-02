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
class ChooseViewController: UIViewController ,CLLocationManagerDelegate, UIGestureRecognizerDelegate, GMSMapViewDelegate{
    @IBOutlet weak var chooseDistanceButton: UIBarButtonItem!
    
    var storyBoard:UIStoryboard!
    var chooseViewController: ChoosePopViewController!
    var route:Route!
    var destinationNotChosen = true
    @IBOutlet weak var mapView: GMSMapView!
    var bump = true
    
    var longPressRecognizer:UILongPressGestureRecognizer!
    var currentLocation:CLLocationCoordinate2D?{
        didSet{
            
        }
    }
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.myLocationEnabled = true
        mapView.delegate = self
        getUsersLocationSetup()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseDistance(sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "ChooseViewStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("sbPopUpID") as! ChoosePopViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)

    }
    
    
    
    
    
    func mapView(mapView: GMSMapView, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        
        handleLongPress(coordinate)
    }
    
    
    
    func handleLongPress(coordinate: CLLocationCoordinate2D) {
        if destinationNotChosen {
            print("Long Location Pressed")
            let marker = GMSMarker(position: coordinate)
            marker.opacity = 0.6
            marker.position = coordinate
            marker.title = "Destination"
            marker.snippet = ""
            marker.map = mapView
            marker.draggable = true
            
            destinationNotChosen = false
        }
        
    }
    
   
    
    
    
    
    
    
    
    
    
}
