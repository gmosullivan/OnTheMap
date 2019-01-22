//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 22/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain( _ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
