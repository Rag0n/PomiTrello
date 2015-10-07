//
//  AppDelegate.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let managedObjectContext = createBoardsMainContext()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        // checks if app has user key for trello api
        if defaults.boolForKey(Constants.hasUserToken) == false {
            let welcomeViewContoller = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.welcomeViewControllerIdentifier) as! WelcomeViewController
            self.window!.rootViewController = welcomeViewContoller
        } else {
            let mainViewController = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.trelloViewControllerIdentifier) as! TrelloTableViewController
            let navCon = UINavigationController(rootViewController: mainViewController)
            self.window!.rootViewController = navCon
        }
        
        guard let vc = window?.rootViewController as? ManagedObjectContextSettable else {
            fatalError("Wrong view controller type(VC should conform to ManagedObjectContextSettable protocol)")
        }
        vc.managedObjectContext = managedObjectContext

        self.window!.makeKeyAndVisible()
    
        return true
    }
}

