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
    
    func buildURL( _ host: String, withPathExtension: String) -> URL {
        var components = URLComponents()
        components.scheme = UrlComponents.ApiScheme
        components.host = host
        components.path = withPathExtension
        return components.url!
    }
    
}
