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
    let managedObjectContext = createCardMainContext()
    
//    let managedObjectContext = createBoardsMainContext()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        

        // checks if app has user key for trello api
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if defaults.boolForKey(Constants.hasUserToken) == false {
//            let welcomeViewContoller = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.welcomeViewControllerIdentifier) as! WelcomeViewController
//            self.window!.rootViewController = welcomeViewContoller
//            welcomeViewContoller.managedObjectContext = managedObjectContext
//        } else {
//            let mainViewController = storyboard.instantiateViewControllerWithIdentifier(StoryBoard.trelloViewControllerIdentifier) as! TrelloTableViewController
//            mainViewController.managedObjectContext = managedObjectContext
//            let navCon = UINavigationController(rootViewController: mainViewController)
//            self.window!.rootViewController = navCon
//        }
        
//        self.window!.makeKeyAndVisible()
        return true
    }
}

