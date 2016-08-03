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
class ChooseViewController: UIViewController ,CLLocationManagerDelegate, UIGestureRecognizerDelegate, GMSMapViewDelegate, ChoosePopViewDelegate {
    @IBOutlet weak var chooseDistanceButton: UIBarButtonItem!
    var distanceTravel:Double = 0
    var minDistance:Double = 0
    var storyBoard:UIStoryboard!
    var chooseViewController: ChoosePopViewController!
    var route:Route!
    var finalDestination:CLLocation!
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
    
    @IBAction func chooseDistance(sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "ChooseViewStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("sbPopUpID") as! ChoosePopViewController
        popOverVC.delegate = self
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        

    }
    
    
    
    
    
    func mapView(mapView: GMSMapView, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        
        handleLongPress(coordinate)
    }
    
    func mapView(mapView: GMSMapView, didEndDraggingMarker marker: GMSMarker) {
         setMinimumDestination(CLLocation(latitude:(currentLocation?.latitude)!, longitude:(currentLocation?.longitude)!), finalLocation: CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude))
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
            setMinimumDestination(CLLocation(latitude:(currentLocation?.latitude)!, longitude:(currentLocation?.longitude)!), finalLocation: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            
        }
        
    }
    
    func setMinimumDestination(currentLocation: CLLocation, finalLocation: CLLocation) {
        var distance = currentLocation.distanceFromLocation(finalLocation)
        distance = distance * 0.000621371 // Convert to miles
        distance = Double(round(distance * 10)/10)
        print(distance)
        finalDestination = finalLocation
        minDistance = distance
        distanceTravel = minDistance
    }
    //MARK: PopViewDelegate
    func minDistanceForPopup(view: ChoosePopViewController) -> Double {
        return minDistance
    }
    
    func didSelectDistance(view: ChoosePopViewController, distance: Double) {
        distanceTravel = distance
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier{
            if segueIdentifier == "toRouteStoryboard"{
                let routeVC = segue.destinationViewController as! RouteTableViewController
                routeVC.distanceToAimFor = distanceTravel
                if let finalDestination = finalDestination{
                     routeVC.endLocation = finalDestination
                }else{
                    routeVC.endLocation = CLLocation(latitude: (currentLocation?.latitude)!, longitude: (currentLocation?.latitude)!)
                }
               
            }
        }
        
    }
    
    
}
