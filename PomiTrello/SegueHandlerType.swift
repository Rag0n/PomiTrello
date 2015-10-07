//
//  SegueHandlerType.swift
//  PomiTrello
//
//  Created by Александр on 07.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    public func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Unknow segue \(segue)")
        }
        return segueIdentifier
    }
    
    public func performSegue(segueIdentifier: SegueIdentifier) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: nil)
    }
}