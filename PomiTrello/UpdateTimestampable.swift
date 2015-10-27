//
//  UpdateTimestampable.swift
//  PomiTrello
//
//  Created by Александр on 27.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//
import Foundation


let UpdateTimestampKey = "updatedAt"

protocol UpdatedTimestampable {
    var updatedAt: NSDate { get set }
}
