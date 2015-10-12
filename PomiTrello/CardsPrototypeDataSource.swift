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
    
    var items: AnyObject
    var cellIdentifier: String
    var configureCell: () -> Void
    
    init(withItems: AnyObject, cellIdentifier: String, configureCell: () -> Void) {
        self.configureCell = configureCell
        self.items = withItems
        self.cellIdentifier = cellIdentifier
        super.init()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
//        configureCell(cell, 
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}