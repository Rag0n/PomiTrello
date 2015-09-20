//
//  TrelloTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TrelloTableViewController: UITableViewController {
    // MARK: - Model
    
    
    // MARK: - Private API
    private var key: String!
    
    private func getAppKey() -> String {
        // получаем приватный ключ приложения из файла Keys.plist
        var keys: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            if let appKey = dict[Constants.appKey] as? String {
                return appKey
            }
        }
        return ""
    }
    
    private func configureKey() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let appKey = getAppKey()
        let token = defaults.objectForKey(Constants.userToken) as? String ?? ""
        key = "key=\(appKey)&token=\(token)"
        defaults.setObject(key, forKey: Constants.queryKey)
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
