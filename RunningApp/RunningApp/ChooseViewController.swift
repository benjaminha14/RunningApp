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
import PermissionScope
class ChooseViewController: UIViewController ,CLLocationManagerDelegate, UIGestureRecognizerDelegate, GMSMapViewDelegate, ChoosePopViewDelegate, UITabBarControllerDelegate {
    @IBOutlet weak var chooseDistanceButton: UIBarButtonItem!
    let pscope = PermissionScope()
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
    
    @IBAction func generateRoute(sender: AnyObject) {
        
        if let finalDestination = finalDestination{
            performSegueWithIdentifier("goToRoute", sender: self)
        }
    }
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.myLocationEnabled = true
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        self.tabBarController?.delegate = self
        pscope.addPermission(LocationAlwaysPermission(), message: "We need our location to create unique running routes for you and also provide directions for them")
        pscope.show({ finished, results in
            print("got results \(results)")
            }, cancelled: { (results) -> Void in
                print("thing was cancelled")
                self.pscope.requestLocationAlways()
        })
        
//        pscope.onCancel = { results in
//            self.pscope.addPermission(LocationAlwaysPermission(), message: "We need our location to create unique running routes for you and also provide directions for them")
//
//        }
//        pscope.onDisabledOrDenied = { results in
//            self.pscope.addPermission(LocationAlwaysPermission(), message: "We need our location to create unique running routes for you and also provide directions for them")
//
//            
//            
//        }
//        
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
        chooseDistanceButton.title = "\(distanceTravel) miles"

    }
    //MARK: PopViewDelegate
    func minDistanceForPopup(view: ChoosePopViewController) -> Double {
        return minDistance
    }
    
    func didSelectDistance(view: ChoosePopViewController, distance: Double) {
        distanceTravel = distance
        chooseDistanceButton.title = "\(distanceTravel) miles"

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navVC = segue.destinationViewController as! UINavigationController
        let routeVC = navVC.viewControllers.first as! RouteTableViewController
        routeVC.distanceToAimFor = distanceTravel
        if let finalDestination = finalDestination{
            routeVC.endLocation = finalDestination
        }
        
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if viewController is RouteTableViewController{
            if let finalDestination = finalDestination{
                
                let routeVC = viewController as! RouteTableViewController
                
                routeVC.endLocation = finalDestination
                routeVC.distanceToAimFor = distanceTravel
                return true
            }
            
            return false
        }
        
        return true
        
    }
    
    
    
    
}
