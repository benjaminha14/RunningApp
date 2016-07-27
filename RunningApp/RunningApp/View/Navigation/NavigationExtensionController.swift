
import MapKit
import GoogleMaps
import RandomColorSwift
extension NavigationViewController{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        print("Updating location ")
        guard let location = locations.first else { return }
        
        if bump {
            bump = false
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
            print("Camera view ")
            

            let marker = GMSMarker()
            
            marker.position =  CLLocationCoordinate2D(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            marker.title = "Your location"
            marker.map = self.mapView
       
            
            
        }
        
    }
    
    func getUsersLocationSetup(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            print("Got permision to get location")
        }
    }
    
    func drawPolyline(route:String){
        let path:GMSPath = GMSPath(fromEncodedPath: route)!
        let route = GMSPolyline(path: path)
        let randomColorForPolyline = randomColor(hue: .Blue, luminosity: .Light)
        color = randomColorForPolyline
        route.strokeColor = color
        route.strokeWidth = 2
       
        route.map = mapView
    }
    
    
    
    // MARK: - Table view data source
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return route.allDirections.count
    }
        
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NavigationCell", forIndexPath: indexPath) as! NavigationCustomCell
        
        
        cell.directions.text = route.allDirections[indexPath.row].direction
        cell.number.text = "\(indexPath.row)"
        cell.number.textColor = color
        
        
        
        return cell
    }

}