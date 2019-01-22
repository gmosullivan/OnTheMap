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
    
}
