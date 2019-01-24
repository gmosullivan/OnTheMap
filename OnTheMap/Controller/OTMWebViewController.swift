//
//  OTMWebViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 24/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit
import WebKit

class OTMWebViewController: UIViewController, WKUIDelegate {

    //Web view
    @IBOutlet weak var webView: WKWebView!
    
    //Url String
    var urlString = "https://auth.udacity.com/sign-up"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
    }

}
