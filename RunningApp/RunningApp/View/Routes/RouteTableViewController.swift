//
//  RouteTableViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 7/21/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import GoogleMaps
class RouteTableViewController: UITableViewController, CLLocationManagerDelegate, RouteGeneratorDelegate,GMSMapViewDelegate, RouteCellDelegate {
    var numberOfRoutesGenerated = 0{
        didSet{
            if(routes.count < 3) {
                initRoutes()
                
                
            }else{
                generating = false
                tableView.reloadData()
                removeLoadingScreen()
            
            }
            
        }
    }
    var location:CLLocation!
    var routeDelegate: RouteGeneratorDelegate!
    var routeGenerator = RouteGenerator()
    var bump = true
    var initial = true
    var generating = true
    var secondBump = true
    var mapView: GMSMapView!
    var chosenRoute: Route!
    var distanceToAimFor:Double!
    var endLocation:CLLocation!
    var currentLocation:CLLocation?{
        didSet{
            if(initial){
                initRoutes()
            }
        }
    }
    var routes = [Route]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreen()
        self.tableView.backgroundColor = UIColor(red: UIColor.getValue(238), green: UIColor.getValue(238), blue: UIColor.getValue(238), alpha: 1.0)
        

        
    

        
    }
    @IBAction func setupTransition(sender: AnyObject) {
        //routes.removeAll()
        
    }
    override func viewWillAppear(animated: Bool) {
        getUsersLocationSetup()
        print("Route view load")
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToRoutes(segue: UIStoryboardSegue) {}
    
    
    
    
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRectMake(x, y, width, height)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.grayColor()
        self.loadingLabel.textAlignment = NSTextAlignment.Center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.frame = CGRectMake(0, 0, 140, 30)
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.spinner.frame = CGRectMake(0, 0, 30, 30)
        self.spinner.startAnimating()
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        
        self.tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
    
}
