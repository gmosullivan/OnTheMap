//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient {
    
    //MARK: Build Url
    func buildUrl( _ host: String, withPathExtension: String) -> URL {
        //Function to store url components and return url for URLRequest
        var components = URLComponents()
        components.scheme = UrlComponents.ApiScheme
        components.host = host
        components.path = withPathExtension
        return components.url!
    }
    
    //MARK: Build Url with Query Items
    func buildUrl( _ host: String, _ path: String, withQueryItems: [String:AnyObject]) -> URL {
        //Function to build url with query items added
        var components = URLComponents()
        components.scheme = UrlComponents.ApiScheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem]()
        //For loop to add key and value from query items array to queryItems
        for (key, value) in withQueryItems {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
    
    //MARK: Substitute key in url
    func substituteKeyIn(url: URL, key: String, value: String) -> URL? {
        //Function to add user id to url
        let urlString = String(describing: url)
        //Check if url contains key
        if urlString.range(of: "\(key)") != nil {
            return URL(string: urlString.replacingOccurrences(of: "\(key)", with: value))
        } else {
            //Otherwise return nil
            return nil
        }
    }
    
    //MARK: Check for error
    func checkForErrorInTask( _ data: Data?, _ response: URLResponse?, error: Error?, _ checkForErrorCompletionHandler: @escaping( _ success: Bool, _ error: String?) -> Void) {
        //Function to check data task doesn't return an error
        guard error == nil else {
            checkForErrorCompletionHandler(false, "Something went wrong!")
            return
        }
        checkForErrorCompletionHandler(true, nil)
    }
    
    func checkForError( _ success: Bool, _ error: String?, _ viewController: UIViewController) {
        //Function to check completion handlers do not return an error
        guard error == nil else {
            if error == "Something went wrong!" {
                displayError(error: error!, "Please check your network connection or try again later.", viewController: viewController)
            } else if error == "Invalid Credentials" {
                displayError(error: error!, "Please check your email address and password are correct and try again.", viewController: viewController)
            } else if error == "Unable to Connect" {
                displayError(error: error!, "Please check your network connection and try again.", viewController: viewController)
            } else {
                displayError(error: "Something went wrong!", "Please check your network connection or try again later.", viewController: viewController)
            }
            return
        }
    }
    
    //MARK: Display Error
    func displayError(error: String, _ description: String, viewController: UIViewController) {
        //Function to display an alert in the view controller if there is an error
        print(error)
        let alert = UIAlertController(title: error, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        //Ensure on main thread
        performUIUpdatesOnMain {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
