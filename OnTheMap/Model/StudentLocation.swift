//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

//MARK: Student Location struct to handle student locations
struct StudentLocation {
    
    static var locations = [StudentLocation]()
    
    let studentUniqueKey: String
    let studentFirstName: String
    let studentLastName: String
    let studentLatitude: Float
    let studentLongitude: Float
    let studentMapString: String
    let studentUrl: String
    
}
