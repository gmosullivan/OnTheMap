//
//  OTMAddLocationViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 24/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class OTMAddLocationViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        urlTextField.delegate = self
        mapView.delegate = self
        geocoding(inProcess: false)
    }
    
    //MARK: Actions
    @IBAction func performForwardGeocoding() {
        //Check the text fields are not empty
        if locationTextField.text == "" || urlTextField.text == "" {
            UdacityClient.sharedInstance().displayError(error: "No location or URL Added", "Please enter your location and a URL.", viewController: self)
            return
        }
        //Add text to model
        UdacityClient.HTTPBodyValues.mapString = locationTextField.text!
        UdacityClient.HTTPBodyValues.mediaURL = urlTextField.text!
        //Display activity indicator
        geocoding(inProcess: true)
        //Create geocoder
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(UdacityClient.HTTPBodyValues.mapString) { (placemarks, error) in
            guard error == nil else {
                UdacityClient.sharedInstance().displayError(error: "Unable to find location", "Please check network connection or enter a different location.", viewController: self)
                return
            }
            guard let placemark = placemarks?.first else {
                UdacityClient.sharedInstance().displayError(error: "Unable to find location", "Please check network connection or enter a different location.", viewController: self)
                return
            }
            let location = placemark.location?.coordinate
            UdacityClient.HTTPBodyValues.latitude = location!.latitude
            UdacityClient.HTTPBodyValues.longitude = location!.longitude
            self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            self.geocodingFinished()
        }
    }
    
    @IBAction func postNewLocation() {
        UdacityClient.sharedInstance().postNewLocation(self)
    }
    
    //MARK: SetUI
    func geocoding(inProcess: Bool) {
        if inProcess {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            locationTextField.isHidden = true
            urlTextField.isHidden = true
            findLocationButton.isHidden = true
            mapView.isHidden = true
            finishButton.isHidden = true
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            locationTextField.isHidden = false
            urlTextField.isHidden = false
            findLocationButton.isHidden = false
            mapView.isHidden = true
            finishButton.isHidden = true
        }
    }
    
    func geocodingFinished() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        mapView.isHidden = false
        finishButton.isHidden = false
        locationTextField.isHidden = true
        urlTextField.isHidden = true
        findLocationButton.isHidden = true
    }
    
    //Map view delegate functions
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(UdacityClient.HTTPBodyValues.latitude, UdacityClient.HTTPBodyValues.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
    }

}
