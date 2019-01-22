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
    
    //MARK Initializers
    override init() {
        super .init()
    }
    
    //MARK: Handle Request
    func handleRequest( _ request: URLRequest, _ viewController: UIViewController, withCompletionHandler: @escaping( _ result: Data?, _ error: String?) -> Void) {
        //Function to handle data task
        let request = request
        let task = session.dataTask(with: request) { data,response, error in
            //Check for an error in the data task
            self.checkForErrorInTask(data, response, error: error) { (success, error) in
                //Check error is nil
                self.checkForError(success, error, viewController)
                //Check status code
                self.checkStatusCode(data, response, error as? Error) { (success, error) in
                    //Pass data
                    withCompletionHandler(data, error)
                }
            }
        }
        task.resume()
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        //Create a singleton to allow global access of shared instance
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
