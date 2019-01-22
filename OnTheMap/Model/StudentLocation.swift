//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

//MARK: Student Location struct to handle student locations
struct StudentLocation {
    
    //MARK: Locations array to store locations
    static var locations = [StudentLocation]()
    
    //MARK: Constants
    let studentUniqueKey: String
    let studentFirstName: String
    let studentLastName: String
    let studentLatitude: Float
    let studentLongitude: Float
    let studentMapString: String
    let studentUrl: String
    
    //MARK: Initializers
    init(dictionary: [String:AnyObject]) {
        //Takes dictionary and adds results to Studden Location properties
        if dictionary["uniqueKey"] != nil {
            studentUniqueKey = dictionary["uniqueKey"] as! String
        } else {
            //Enters a default if dictionary result is nil
            studentUniqueKey = "1234"
        }
        if dictionary["firstName"] != nil {
            studentFirstName = dictionary["firstName"] as! String
        } else {
            studentFirstName = "firstName"
        }
        if dictionary["lastName"] != nil {
            studentLastName = dictionary["lastName"] as! String
        } else {
            studentLastName = "lastName"
        }
        if dictionary["latitude"] != nil {
            studentLatitude = dictionary["latitude"] as! Float
        } else {
            studentLatitude = 0.00
        }
        if dictionary["longitude"] != nil {
            studentLongitude = dictionary["longitude"] as! Float
        } else {
            studentLongitude = 0.00
        }
        if dictionary["mapString"] != nil {
            studentMapString = dictionary["mapString"] as! String
        } else {
            studentMapString = "London"
        }
        if dictionary["mediaURL"] != nil {
            studentUrl = dictionary["mediaURL"] as! String
        } else {
            studentUrl = "https://failblog.cheezburger.com/"
        }
    }
    
    //MARK: Student Location Methods
    static func studentLocationsFrom(results: [[String:AnyObject]]) -> [StudentLocation] {
        //For loop iterates through results....
        for result in results {
            //and adds locations to array
            locations.append(StudentLocation(dictionary: result))
        }
        return locations
    }
    
}
