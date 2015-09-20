//
//  TrelloTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TrelloTableViewController: UITableViewController {
    // MARK: - Private API
    private var key: String!
    
    private struct Constants {
        static var userToken = "userToken"
        static var AppKey = "AppKey"
    }
    
//    private func authorization() {
//        let url = NSURL(string: Constants.tokenURL)!
//        let urlSession = NSURLSession.sharedSession()
//        let task = urlSession.dataTaskWithURL(url) { (data, response, error) -> Void in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            print(data)
//            print(response)
//            print("Now authorized")
//            self.isAuthorized = true
//        }
//        task.resume()
//    }
    
    private func configureKey() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let appKey = defaults.objectForKey(Constants.AppKey) as? String ?? ""
        let token = defaults.objectForKey(Constants.userToken) as? String ?? ""
        key = "?key=\(appKey)&token=\(token)"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKey()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
