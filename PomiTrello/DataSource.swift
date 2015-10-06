//
//  DataSource.swift
//  PomiTrello
//
//  Created by Александр on 06.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

protocol DataSourceDelegate: class {
    typealias Object
    func cellIdentifierForObject(object: Object) -> String
}
