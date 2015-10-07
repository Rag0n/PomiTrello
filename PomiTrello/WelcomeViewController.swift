//
//  WelcomeViewController.swift
//  PomiTrello
//
//  Created by Александр on 29.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController, ManagedObjectContextSettable {

    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var loginButton: UIButton!

    @IBAction func login() {
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.loginButton.bounds.size.width += 80
        }, completion: nil)
        let lvc = storyboard!.instantiateViewControllerWithIdentifier(StoryBoard.loginViewControllerIdentifier)
        presentViewController(lvc, animated: true, completion: nil)
    }
}
