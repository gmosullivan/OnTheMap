//
//  OTMMapViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 24/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit
import MapKit

class OTMMapViewController: UIViewController, MKMapViewDelegate {

    //MARK: Annotations array
    var annotations = [MKPointAnnotation]()
    
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayStudentLocations()
        self.mapView.reloadInputViews()
    }
    
    //MARK: Logout
    @IBAction func logout() {
        UdacityClient.sharedInstance().taskForLogout(self)
    }
    
    //MARK: Display student locations
    func displayStudentLocations() {
        //For loop to add annotations to annotations array
        for location in StudentLocation.locations {
            //Set coordinates
            let lat = CLLocationDegrees(location.studentLatitude)
            let lon = CLLocationDegrees(location.studentLongitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            //Set title
            let first = location.studentFirstName
            let last = location.studentLastName
            //Set subtitle
            let url = location.studentUrl
            //Add to annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = url
            //Add to annotations array
            annotations.append(annotation)
        }
        //Add array to map view
        mapView.addAnnotations(annotations)
    }
    
    //MARK: MKMapView Delegate fuctions
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Create pin
        let reuseId = "pin"
        //Create pin view
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        //Check pin view
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }

}
