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
                    //Check error is still nil
                    self.checkForError(success, error, viewController)
                    //Pass data
                    withCompletionHandler(data, error)
                }
            }
        }
        task.resume()
    }
    
    //MARK: Task for login
    func taskForLogin ( _ viewController: UIViewController) {
        //Create url
        let loginUrl = buildUrl(UrlComponents.onTheMapHost, withPathExtension: UrlComponents.onTheMapSessionPath)
        //Create request
        var request = URLRequest(url: loginUrl)
        request.httpMethod = Methods.post
        request.addValue(HTTPHeaderValues.json, forHTTPHeaderField: HTTPHeaderKeys.accept)
        request.addValue(HTTPHeaderValues.json, forHTTPHeaderField: HTTPHeaderKeys.contentType)
        //Add HTTP Body
        let body = [HTTPBodyKeys.udacity: [HTTPBodyKeys.username: HTTPBodyValues.username, HTTPBodyKeys.password: HTTPBodyValues.password]]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
            return
        }
        //Call handle request
        handleRequest(request, viewController) { (result, error) in
            //Remove first 5 characters
            self.parseDataFromRange(result, error) { (result, error) in
                //Get account info
                guard let accountInfo = result![JsonResponseKeys.account] as? [String:AnyObject] else {
                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                    return
                }
                //Check if user is registered
                guard let isRegistered = accountInfo[JsonResponseKeys.registered] as? Bool else {
                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                    return
                }
                //Get account id
                guard let accountId = accountInfo[JsonResponseKeys.key] as? String else {
                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                    return
                }
                //Add account id to model
                UserId.userId = accountId
                if isRegistered {
                    //Call get user details
                        //Call get student locations to propegate Map and Table views
                            //Move to main thread
                            performUIUpdatesOnMain {
                                //Login
                                viewController.performSegue(withIdentifier: "Login", sender: viewController)
                            }
                        } else {
                            self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                        }
            }
        }
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
