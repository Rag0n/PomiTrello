//
//  Extensions.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentViewController: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController!
        } else {
            return self
        }
    }
}