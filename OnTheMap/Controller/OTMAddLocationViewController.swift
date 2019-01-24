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

class OTMAddLocationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        locationTextField.isHidden = false
        urlTextField.delegate = self
        urlTextField.isHidden = false
        findLocationButton.isHidden = false
        mapView.isHidden = true
    }

}
