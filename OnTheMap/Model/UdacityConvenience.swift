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
    
}