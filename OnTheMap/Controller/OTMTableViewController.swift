//
//  OTMTableViewController.swift
//  OnTheMap
//
//  Created by Gareth O'Sullivan on 24/01/2019.
//  Copyright © 2019 Locust Redemption. All rights reserved.
//

import UIKit

class OTMTableViewController: UITableViewController {

    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Logout
    @IBAction func logout() {
        UdacityClient.sharedInstance().taskForLogout(self)
    }

    //MARK: - Table view data source
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Get url from Student Location
        let locationURL = StudentLocation.locations[indexPath.row].studentUrl
        //Check url
        if locationURL.contains("http") {
            //Instantiate Web view controller
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "OTMWebViewController") as! OTMWebViewController
            //Pass url
            viewController.urlString = locationURL
            //Pop to Web view controller
            self.navigationController!.popToViewController(viewController, animated: true)
        } else {
            UdacityClient.sharedInstance().displayError(error: "Invalid URL", "This does not appear to be a valid URL. Please try another student.", viewController: self)
        }
    }

}
