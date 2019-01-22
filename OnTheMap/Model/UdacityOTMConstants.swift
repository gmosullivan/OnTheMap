//
//  UdacityOTMConstants.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

extension UdacityClient {
    
    struct HTTPBodyKeys {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let mediaUrl = "mediaURL"
        static let password = "password"
        static let udacity = "udacity"
        static let uniqueKey = "uniqueKey"
        static let username = "username"
    }
    
    struct HTTPBodyValues {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = 0.00
        static let longitude = 0.00
        static let mapString = "London"
        static let mediaURL = "https://www.udacity.com"
        static let password = "password"
        static let uniqueKey = "1234"
        static let username = "name@mail.com"
    }
    
}
