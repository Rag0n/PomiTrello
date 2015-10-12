//
//  CardsPrototypeDataSource.swift
//  PomiTrello
//
//  Created by Александр on 12.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import UIKit

class CardsPrototypeDataSource: NSObject, UITableViewDataSource {
    
    var items: [AnyObject]
    var cellIdentifier: String
    var configureCell: (cell: UITableViewCell, item: AnyObject) -> Void
    
    init(withItems: AnyObject, cellIdentifier: String, configureCell: (cell: UITableViewCell, item: AnyObject) -> Void) {
        self.configureCell = configureCell
        self.items = withItems as! [AnyObject]
        self.cellIdentifier = cellIdentifier
        super.init()
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return items[indexPath.row]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let item = itemAtIndexPath(indexPath)
        
        configureCell(cell: cell, item: item)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}