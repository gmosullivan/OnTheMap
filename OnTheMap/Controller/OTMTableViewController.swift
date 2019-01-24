//
//  OTMTableViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 24/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit

class OTMTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocation.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "locations", for: indexPath)
        //Get location for row from locations array
        let location = StudentLocation.locations[indexPath.row]
        //Configure cell
        cell.textLabel?.text = "\(location.studentFirstName) \(location.studentLastName)"
        cell.detailTextLabel?.text = "\(location.studentUrl)"
        //Return cell
        return cell
    }

}
