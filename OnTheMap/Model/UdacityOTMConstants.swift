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
    
    struct HTTPHeaderKeys {
        static let accept = "Accept"
        static let apiKey = "X-Parse-REST-API-Key"
        static let applicationId = "X-Parse-Application-Id"
        static let contentType = "Content-Type"
        static let xsrfToken = "X-XSRF-Token"
    }
    
    struct HTTPHeaderValues {
        static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let json = "application/json"
        static let xsrfToken = "XSRF-TOKEN"
    }
    
}
