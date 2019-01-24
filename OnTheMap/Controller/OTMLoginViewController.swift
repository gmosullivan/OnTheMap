//
//  OTMLoginViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit

class OTMLoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: Login Button
    @IBAction func login() {
        //Check text fields are not empty
        if emailTextField.text! == "" || passwordTextField.text! == "" {
            UdacityClient.sharedInstance().displayError(error: "Missing email and/or password", "Please enter your email address and password", viewController: self)
            return
        }
        //Add username to model
        UdacityClient.HTTPBodyValues.username = emailTextField.text!
        //Add password to model
        UdacityClient.HTTPBodyValues.password = passwordTextField.text!
        //Call task for login
        UdacityClient.sharedInstance().taskForLogin(self)
    }
    
    //MARK: Text Field Delegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

