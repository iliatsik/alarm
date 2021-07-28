//
//  MapViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 28.07.21.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude  : Double?
    var  longitude : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: latitude!, longitude: longitude!)
        mapView.centerToLocation(initialLocation)

        let oahuCenter = CLLocation(latitude: latitude!, longitude: longitude!)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }

}


private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
