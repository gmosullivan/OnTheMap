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

    //MARK: Web view
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: Url String
    var urlString = "https://auth.udacity.com/sign-up"
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
    }
    
    //MARK: Load web view
    func loadWebView( _ url: String) {
        //Create request
        let request = URLRequest(url: URL(string: urlString)!)
        //Add sub view
        self.view.addSubview(webView)
        //Load request
        webView.load(request)
    }

}
