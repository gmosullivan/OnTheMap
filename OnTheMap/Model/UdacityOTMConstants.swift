//
//  UdacityOTMConstants.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

extension UdacityClient {
    
    //MARK: HTTPBodyKeys
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
    
    //MARK: HTTPBodyValues
    struct HTTPBodyValues {
        static var firstName = "firstName"
        static var lastName = "lastName"
        static var latitude = 0.00
        static var longitude = 0.00
        static var mapString = "London"
        static var mediaURL = "https://www.udacity.com"
        static var password = "password"
        static var uniqueKey = "1234"
        static var username = "name@mail.com"
    }
    
    //MARK: HTTPHeaderKeys
    struct HTTPHeaderKeys {
        static let accept = "Accept"
        static let apiKey = "X-Parse-REST-API-Key"
        static let applicationId = "X-Parse-Application-Id"
        static let contentType = "Content-Type"
        static let xsrfToken = "X-XSRF-Token"
    }
    
    //MARK: HTTPHeaderValues
    struct HTTPHeaderValues {
        static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let json = "application/json"
        static let xsrfToken = "XSRF-TOKEN"
    }
    
    //MARK: JsonResponseKeys
    struct JsonResponseKeys {
        static let account = "account"
        static let firstName = "first_name"
        static let key = "key"
        static let lastName = "last_name"
        static let results = "results"
        static let session = "session"
        static let registered = "registered"
    }
    
    //MARK: Methods
    struct Methods {
        static let delete = "DELETE"
        static let post = "POST"
    }
    
    //MARK: ParameterKeys
    struct ParameterKeys {
        static let limit = "limit"
        static let order = "order"
    }
    
    //MARK: ParameterValues
    struct ParameterValues {
        static let limit = "100"
        static let order = "-updatedAt"
    }
    
    //MARK: UrlComponents
    struct UrlComponents {
        static let ApiScheme = "https"
        static let id = "id"
        static let onTheMapHost = "onthemap-api.udacity.com"
        static let onTheMapSessionPath = "/v1/session"
        static let onTheMapUsersPath = "/v1/users/id"
        static let parseHost = "parse.udacity.com"
        static let parsePath = "/parse/classes/StudentLocation"
    }
    
    //MARK: UserId
    struct UserId {
        static var userId = "0"
    }
    
}
