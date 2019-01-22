//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient: NSObject {
    
    //MARK: Shared session
    var session = URLSession.shared
    
    //MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        //Create a singleton to allow global access of shared instance
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
