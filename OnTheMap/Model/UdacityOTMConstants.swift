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
    
    struct JsonResponseKeys {
        static let account = "account"
        static let firstName = "first_name"
        static let key = "key"
        static let lastName = "lastName"
        static let results = "results"
        static let session = "session"
        static let registered = "registered"
    }
    
    struct Methods {
        static let delete = "DELETE"
        static let post = "POST"
    }
    
    struct ParameterKeys {
        static let limit = "limit"
        static let order = "order"
    }
    
    struct ParameterValues {
        static let limit = "100"
        static let order = "-updatedAt"
    }
    
    struct UrlComponents {
        static let ApiScheme = "https"
        static let id = "id"
        static let onTheMapHost = "onthemap-api.udacity.com"
        static let onTheMapSessionPath = "/v1/session"
        static let onTheMapUsersPath = "/v1/users/id"
        static let parseHost = "parse.udacity.com"
        static let parsePath = "/parse/classes/StudentLocation"
    }
    
    struct userId {
        static var userId = "0"
    }
    
}
