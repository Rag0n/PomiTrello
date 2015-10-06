//
//  ConfigurableCell.swift
//  PomiTrello
//
//  Created by Александр on 06.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

protocol ConfigurableCell {
    typealias DataSource
    func configureForObject(object: DataSource)
}
