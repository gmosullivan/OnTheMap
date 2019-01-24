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
            //Parse data with first 5 characters removed
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
                    self.getUserDetails(viewController) { (success) in
                        //Check success
                        if success {
                            //Call get student locations to propegate Map and Table views
                            self.getStudentLocations(viewController) { (success) in
                                //Check success
                                if success {
                                    //Move to main thread
                                    performUIUpdatesOnMain {
                                        //Login
                                        viewController.performSegue(withIdentifier: "Login", sender: viewController)
                                    }
                                } else {
                                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                                }
                            }
                        } else {
                            self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                        }
                    }
                } else {
                    self.displayError(error: "Something ent wrong!", "Please check your network connection or try again later.", viewController: viewController)
                }
            }
        }
    }
    
    //MARK: Task for logout
    func taskForLogout( _ viewController: UIViewController) {
        //Create url
        let logoutUrl = buildUrl(UrlComponents.onTheMapHost, withPathExtension: UrlComponents.onTheMapSessionPath)
        //Create request
        var request = URLRequest(url: logoutUrl)
        request.httpMethod = Methods.delete
        //Check for xsrf cookie
        var xsrfCookie: HTTPCookie? = nil
        let sharedStorage = HTTPCookieStorage.shared
        for cookie in sharedStorage.cookies! {
            if cookie.name == HTTPHeaderValues.xsrfToken { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: HTTPHeaderKeys.xsrfToken)
        }
        //Call handle request
        handleRequest(request, viewController) { (result, error) in
            //Parse data with first 5 characters removed
            self.parseDataFromRange(result, error) { (result, error) in
                //Get session from result
                guard let session = result![JsonResponseKeys.session] as? [String:Any] else {
                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                    return
                }
                //Check session array is not empty
                if session.count > 0 {
                    //Move to main
                    performUIUpdatesOnMain {
                        viewController.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    //MARK: Get user details
    func getUserDetails( _ viewController: UIViewController, _ userCompletionHandler: @escaping( _ success: Bool) -> Void) {
        //Create url
        let userInfoUrl = buildUrl(UrlComponents.onTheMapHost, withPathExtension: UrlComponents.onTheMapUsersPath)
        //Add user id to url
        var mutableUrl: URL = userInfoUrl
        mutableUrl = substituteKeyIn(url: userInfoUrl, key: UrlComponents.id, value: UserId.userId)!
        //Create request
        let request = URLRequest(url: mutableUrl)
        //Call handle request
        handleRequest(request, viewController) { (result, error) in
            //Parse data with first 5 characters removed
            self.parseDataFromRange(result, error) { (result, error) in
                //Get user's first name
                guard let userFirstName = result![JsonResponseKeys.firstName] as? String else {
                    userCompletionHandler(false)
                    return
                }
                //Add first name to model
                HTTPBodyValues.firstName = userFirstName
                //Get user's last name
                guard let userLastName = result![JsonResponseKeys.lastName] as? String else {
                    userCompletionHandler(false)
                    return
                }
                //Add last name to model
                HTTPBodyValues.lastName = userLastName
                userCompletionHandler(true)
            }
        }
    }
    
    //MARK: Get Student Locations
    func getStudentLocations( _ viewController: UIViewController, _ locationsCompletionHandler: @escaping( _ success: Bool) -> Void) {
        //Set query items for url
        let queryItems = [ParameterKeys.limit: ParameterValues.limit, ParameterValues.order: ParameterValues.order] as [String:AnyObject]
        //Create url
        let studentLocationUrl = buildUrl(UrlComponents.parseHost, UrlComponents.parsePath, withQueryItems: queryItems)
        //Create request
        var request = URLRequest(url: studentLocationUrl)
        request.addValue(HTTPHeaderValues.applicationId, forHTTPHeaderField: HTTPHeaderKeys.applicationId)
        request.addValue(HTTPHeaderValues.apiKey, forHTTPHeaderField: HTTPHeaderKeys.apiKey)
        //Call hande request
        handleRequest(request, viewController) { (result, error) in
            //Parse result
            self.parseResult(result, error: error) { (result, error) in
                //Get results
                guard let results = result![JsonResponseKeys.results] as? [[String:AnyObject]] else {
                    locationsCompletionHandler(false)
                    return
                }
                //Add results to locations array
                StudentLocation.locations = StudentLocation.studentLocationsFrom(results: results)
                locationsCompletionHandler(true)
            }
        }
    }
    
    //MARK: Post new location
    func postNewLocation( _ viewController: UIViewController) {
        //Create url
        let newLocationUrl = buildUrl(UrlComponents.parseHost, withPathExtension: UrlComponents.parsePath)
        //Create request
        var request = URLRequest(url: newLocationUrl)
        request.httpMethod = Methods.post
        request.addValue(HTTPHeaderValues.applicationId, forHTTPHeaderField: HTTPHeaderKeys.applicationId)
        request.addValue(HTTPHeaderValues.apiKey, forHTTPHeaderField: HTTPHeaderKeys.apiKey)
        request.addValue(HTTPHeaderValues.json, forHTTPHeaderField: HTTPHeaderKeys.contentType)
        //Add http body
        let body: [String:Any] = [
            HTTPBodyKeys.uniqueKey: HTTPBodyValues.uniqueKey,
            HTTPBodyKeys.firstName: HTTPBodyValues.firstName,
            HTTPBodyKeys.lastName: HTTPBodyValues.lastName,
            HTTPBodyKeys.mapString: HTTPBodyValues.mapString,
            HTTPBodyKeys.mediaUrl: HTTPBodyValues.mediaURL,
            HTTPBodyKeys.latitude: HTTPBodyValues.latitude,
            HTTPBodyKeys.longitude: HTTPBodyValues.longitude
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
            return
        }
        //Handle requset
        handleRequest(request, viewController) { (result, error) in
            //Parse result
            self.parseResult(result, error: error) { (result, error) in
                //Check result isn't empty
                if result!.count > 0 {
                    viewController.dismiss(animated: true)
                } else {
                    self.displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
                    return
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
