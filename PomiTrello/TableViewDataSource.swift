//
//  TableViewDataSource.swift
//  PomiTrello
//
//  Created by Александр on 06.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TableViewDataSource<Delegate: DataSourceDelegate, Data: DataProvider, Cell: UITableViewCell where Delegate.Object == Data.Object, Cell: ConfigurableCell, Cell.DataSource == Data.Object>: NSObject, UITableViewDataSource {
    
}
